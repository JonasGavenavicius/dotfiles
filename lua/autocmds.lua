local api = vim.api
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

-- Create augroup for general user autocommands
local user_group = augroup("UserConfig", { clear = true })

-- Autocommand group that runs after UI is ready and file is loaded
local file_post_group = augroup("NvFilePost", { clear = true })

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = file_post_group,
  callback = function(args)
    local buf = args.buf
    local event = args.event
    local file = api.nvim_buf_get_name(buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })

    -- Track UIEnter to ensure we're past UI init
    if not vim.g.ui_entered and event == "UIEnter" then
      vim.g.ui_entered = true
    end

    -- Only continue if file is real, not a special buffer, and UI entered
    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      api.nvim_del_augroup_by_name("NvFilePost")

      -- Defer FileType and EditorConfig handling
      vim.schedule(function()
        api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(buf)
        end
      end)
    end
  end,
})

-- Resize all windows equally when terminal is resized
autocmd("VimResized", {
  group = user_group,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
