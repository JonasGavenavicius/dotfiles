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
    { require "configs.planary" },
    { require "configs.lspkind" },
    { require "configs.web-icons" },
    { require "configs.which-key" },
    { require "configs.mason" },
    { require "configs.lspconfig" },
    { require "configs.cmp" },
    { require "configs.telescope" },
    { require "configs.treesitter" },
    { require "configs.conform" },
    { require "configs.rustaceanvim" },
    { require "configs.rust" },
    { require "configs.crates" },
    { require "configs.dap" },
    { require "configs.dap_ui" },
    { require "configs.go-nvim" },
    { require "configs.lualine" },
    { require "configs.autopairs" },
    { require "configs.fzf" },
    { require "configs.markdown-preview" },
    { require "configs.nvim-lint" },
    { require "configs.vim-rails" },
    { require "configs.nvim-ufo" },
    { require "configs.harpoon" },
    { require "configs.git-worktree" },
    { require "configs.persistence" },
    { require "configs.breadcrumbs" },
    { require "configs.catppuccin" },
    -- { require "configs.rose-pine" },
    { require "configs.ruby" },
    { require "configs.copilot" },
    { require "configs.snacks" },
    { require "configs.neotest" }
})

require "options"
require "autocmds"

vim.schedule(function()
    require "mappings"
end)
