-- Setup for go.nvim
local M = {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup({
            goimport = 'goimports',
            gofmt = true,
        })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
}

return M
