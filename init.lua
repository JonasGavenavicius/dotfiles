-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
require "options"
require "autocmds"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
    -- Themes
    { require "configs.themes.catppuccin" },
    -- { require "configs.themes.material" },
    -- { require "configs.themes.cyberdream" },

    -- Plugins
    { require "configs.plenary" },
    { require "configs.lspkind" },
    { require "configs.web-icons" },
    { require "configs.which-key" },
    { require "configs.mason" },
    { require "configs.lspconfig" },
    { require "configs.cmp" },
    { require "configs.treesitter" },
    { require "configs.conform" },
    { require "configs.dap" },
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
    { require "configs.gitsigns" },
    { require "configs.nvim-scrollbar" },
    { require "configs.gitlinker" },
    { require "configs.git-owners" },
    { require "configs.snacks" },
    { require "configs.diffview" },
    { require "configs.twilight" },
    { require "configs.render-markdown" },
    -- { require 'configs.avante' },
})
vim.schedule(function()
    require "mappings"
end)
