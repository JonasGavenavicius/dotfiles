-- lua/git-owners/init.lua
local M = {}

-- Cache for owners data
local owners_cache = {}
local cache_timeout = 30000 -- 30 seconds

-- Find git root directory
local function find_git_root()
  local current_dir = vim.fn.expand('%:p:h')
  while current_dir ~= '/' do
    if vim.fn.isdirectory(current_dir .. '/.git') == 1 then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
  end
  return nil
end

-- Parse OWNERS file
local function parse_owners_file(filepath)
  local owners = {}
  local file = io.open(filepath, 'r')
  if not file then
    return owners
  end
  
  for line in file:lines() do
    line = line:gsub('^%s+', ''):gsub('%s+$', '') -- trim whitespace
    if line ~= '' and not line:match('^#') then
      -- Handle different OWNERS file formats
      if line:match('@') then
        table.insert(owners, line)
      elseif line:match('%w+') then
        table.insert(owners, line)
      end
    end
  end
  file:close()
  return owners
end

-- Find applicable OWNERS file for current file
local function find_owners_for_file(filepath)
  local git_root = find_git_root()
  if not git_root then
    return {}
  end
  
  local relative_path = filepath:gsub(git_root .. '/', '')
  local dir_path = vim.fn.fnamemodify(relative_path, ':h')
  
  -- Look for OWNERS files from current directory up to git root
  while dir_path and dir_path ~= '.' do
    local owners_file = git_root .. '/' .. dir_path .. '/OWNERS'
    if vim.fn.filereadable(owners_file) == 1 then
      return parse_owners_file(owners_file)
    end
    dir_path = vim.fn.fnamemodify(dir_path, ':h')
    if dir_path == '.' then break end
  end
  
  -- Check root OWNERS file
  local root_owners = git_root .. '/OWNERS'
  if vim.fn.filereadable(root_owners) == 1 then
    return parse_owners_file(root_owners)
  end
  
  return {}
end

-- Get owners for current buffer with caching
local function get_current_owners()
  local filepath = vim.fn.expand('%:p')
  if filepath == '' then
    return {}
  end
  
  local now = vim.loop.now()
  local cache_key = filepath
  
  if owners_cache[cache_key] and 
     (now - owners_cache[cache_key].timestamp) < cache_timeout then
    return owners_cache[cache_key].owners
  end
  
  local owners = find_owners_for_file(filepath)
  owners_cache[cache_key] = {
    owners = owners,
    timestamp = now
  }
  
  return owners
end

-- Format owners for display
local function format_owners(owners)
  if #owners == 0 then
    return "No owners"
  end
  
  local formatted = {}
  for _, owner in ipairs(owners) do
    -- Clean up display format
    local clean_owner = owner:gsub('@.*', ''):gsub('.*/', '')
    table.insert(formatted, clean_owner)
    if #formatted >= 3 then -- Limit display to prevent statusline overflow
      table.insert(formatted, '...')
      break
    end
  end
  
  return "👥 " .. table.concat(formatted, ", ")
end

-- Main function to get statusline component
function M.get_owners_statusline()
  local owners = get_current_owners()
  return format_owners(owners)
end

-- Setup function
function M.setup(opts)
  opts = opts or {}
  
  -- Override cache timeout if provided
  if opts.cache_timeout then
    cache_timeout = opts.cache_timeout
  end
  
  -- Create autocommands to refresh cache
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    group = vim.api.nvim_create_augroup("GitOwners", { clear = true }),
    callback = function()
      -- Clear cache for current file to force refresh
      local filepath = vim.fn.expand('%:p')
      owners_cache[filepath] = nil
    end
  })
end

return M
