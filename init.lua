vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '󰌵',
            [vim.diagnostic.severity.INFO] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
  -- Use the default configuration
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  -- Alternatively, customize specific options
  virtual_lines = {
   -- Only show virtual line diagnostics for the current cursor line
   current_line = true,
  },
})

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
    -- Themes
    -- { require "configs.themes.catppuccin" },
    { require "configs.themes.material" },

    -- Plugins
    { require "configs.plenary" },
    { require "configs.lspkind" },
    { require "configs.web-icons" },
    { require "configs.which-key" },
    { require "configs.mason" },
    { require "configs.lspconfig" },
    { require "configs.cmp" },
    { require "configs.telescope" },
    { require "configs.treesitter" },
    { require "configs.conform" },
    { require "configs.dap" },
    { require "configs.dap_ui" },
    { require "configs.lualine" },
    { require "configs.autopairs" },
    { require "configs.nvim-lint" },
    { require "configs.nvim-ufo" },
    { require "configs.harpoon" },
    { require "configs.persistence" },
    { require "configs.breadcrumbs" },
    { require "configs.ruby" },
    { require "configs.copilot" },
    { require "configs.neotest" },
    { require "configs.alpha-nvim" },
    { require "configs.nvim-tree" },
    { require "configs.oil-nvim" },
    { require "configs.mini-indentscope" },
    { require "configs.toggleterm" },
    { require "configs.gitsigns"},
})

require "options"
require "autocmds"

vim.schedule(function()
    require "mappings"
end)
