local M = {}

-- Cache for owners data
local owners_cache = {}
local cache_timeout = 30000 -- 30 seconds

local Path = require("plenary.path")

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

-- Parse CODEOWNERS file
local function parse_codeowners_file(filepath)
  local rules = {}
  local file = io.open(filepath, 'r')
  if not file then
    return rules
  end

  for line in file:lines() do
    line = line:gsub('^%s+', ''):gsub('%s+$', '') -- trim
    if line ~= '' and not line:match('^#') then
      local parts = {}
      for part in line:gmatch('%S+') do
        table.insert(parts, part)
      end

      if #parts >= 2 then
        local pattern = parts[1]
        local owners = {}
        for i = 2, #parts do
          table.insert(owners, parts[i])
        end
        table.insert(rules, { pattern = pattern, owners = owners })
      end
    end
  end
  file:close()
  return rules
end

-- Match a file path against a CODEOWNERS pattern
local function matches_pattern(filepath, pattern)
  filepath = filepath:gsub("\\", "/")
  pattern = pattern:gsub("\\", "/")

  -- Remove leading slash from pattern
  if pattern:sub(1, 1) == "/" then
    pattern = pattern:sub(2)
  end

  -- Check if pattern ends with slash (directory pattern)
  local is_directory_pattern = pattern:sub(-1) == "/"
  if is_directory_pattern then
    pattern = pattern:sub(1, -2) -- remove trailing slash
  end

  -- Escape Lua pattern special chars
  local function escape(str)
    return str:gsub("([%^%$%(%)%%%.%[%]%+%-%?])", "%%%1")
  end

  local lua_pattern = escape(pattern)
  lua_pattern = lua_pattern
    :gsub("%%*%%*", ".*")         -- convert **
    :gsub("%%*", "[^/]*")         -- convert *
  
  -- For directory patterns, match if filepath starts with pattern + "/"
  if is_directory_pattern then
    lua_pattern = lua_pattern .. "/.*"
    return filepath:match("^" .. lua_pattern .. "$") ~= nil
  else
    -- Exact match for files
    return filepath:match("^" .. lua_pattern .. "$") ~= nil
  end
end

-- Find applicable CODEOWNERS for current file
local function find_owners_for_file(filepath)
  local git_root = find_git_root()
  if not git_root then
    return {}
  end

  local relative_path = Path:new(filepath):make_relative(git_root):gsub("\\", "/")

  local codeowners_locations = {
    git_root .. '/CODEOWNERS',
    git_root .. '/.github/CODEOWNERS',
    git_root .. '/docs/CODEOWNERS'
  }

  for _, codeowners_file in ipairs(codeowners_locations) do
    if vim.fn.filereadable(codeowners_file) == 1 then
      local rules = parse_codeowners_file(codeowners_file)

      local matched_owners = {}
      -- Process rules in reverse order - later rules override earlier ones
      for i = #rules, 1, -1 do
        local rule = rules[i]
        if matches_pattern(relative_path, rule.pattern) then
          matched_owners = rule.owners
          break -- Use first match (which is the last/most specific rule)
        end
      end

      if #matched_owners > 0 then
        return matched_owners
      end
    end
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

-- Format owners for statusline
local function format_owners(owners)
  if #owners == 0 then
    return "No owners"
  end

  local formatted = {}
  for _, owner in ipairs(owners) do
    local clean_owner = owner:gsub('^@', ''):gsub('.*/', '')
    table.insert(formatted, clean_owner)
    if #formatted >= 2 then
      table.insert(formatted, '...')
      break
    end
  end

  return "👥 " .. table.concat(formatted, ", ")
end

function M.get_owners_statusline()
  local owners = get_current_owners()
  return format_owners(owners)
end

function M.setup(opts)
  opts = opts or {}

  if opts.cache_timeout then
    cache_timeout = opts.cache_timeout
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("GitOwners", { clear = true }),
    callback = function()
      local filepath = vim.fn.expand('%:p')
      owners_cache[filepath] = nil
    end
  })
end

return M
