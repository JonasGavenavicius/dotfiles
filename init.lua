vim.g.mapleader = " "
vim.opt.termguicolors = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
    "nvim-lua/plenary.nvim",
    { require "configs.theme" },
    { require "configs.bufferline" },
    { require "configs.nvimtree" },
    { require "configs.which-key" },
    { require "configs.gitsigns" },
    -- { require "configs.lsp-zero" },
    { require "configs.mason" },
    { require("configs.lspconfig") },
    { require "configs.cmp" },
    { require "configs.telescope" },
    { require "configs.treesitter" },
    { require "configs.conform" },
    -- { require "configs.flash" },
    { require "configs.rustaceanvim" },
    { require "configs.rust" },
    { require "configs.crates" },
    { require "configs.dap" },
    { require "configs.dap_ui" },
    { require "configs.go-nvim" },
    -- { require "configs.gopher" },
    { require "configs.trouble" },
    { require "configs.noice" },
    { require "configs.lualine" },
    { require "configs.alpha-nvim" },
    { require "configs.autopairs" },
    -- { require "configs.codeium" },
    { require "configs.fzf" },
    -- { require "configs.indent-blankline" },
    { require "configs.markdown-preview" },
    { require "configs.nvim-lint" },
    { require "configs.vim-rails" },
    { require "configs.nvim-ufo" },
    -- { require "configs.toggleterm" },
})

-- local utils = require("configs.run-code")

-- Example key mappings for calling functions from the utils module
-- vim.api.nvim_set_keymap("n", "<leader>gg", ":lua require('configs.run-code').git()<CR>",
--     { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>cr", ":lua require('configs.run-code').run_code()<CR>",
--     { noremap = true, silent = true })

-- load theme

require "options"
require "autocmds"

-- vim.o.foldlevel = 0
-- vim.o.foldmethod = 'indent'


vim.schedule(function()
    require "mappings"
end)
