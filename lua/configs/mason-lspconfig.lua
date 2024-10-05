local M = {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
        require("mason-lspconfig").setup({
            auto_install = true,
            highlight = { enabled = true },
            indent = { enabled = true },
            ensure_installed = {
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "prismals",
                "pyright",
                "csharp_ls",
                "jsonls",
                "terraformls",
                "emmet_ls",
                "rust_analyzer",
                "omnisharp",
            },
        })
    end,
}

return M
