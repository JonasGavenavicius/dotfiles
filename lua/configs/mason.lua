local M = {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'nvim-lua/plenary.nvim',
    },
}

M.servers = {
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
    "codelldb",
    -- "rust_analyzer",
    "ts_ls",
    "json",
    "htmlbeautifier",
    -- "rustfmt",
    "gofumpt",
    "gopls",
    "gofmt",
    "goimports",
    "prettier",
    "prettierd",
    "stylua",
}

function M.config()
    -- local lsp = require("lsp-zero")
    -- lsp.preset("recommended")

    -- require("lsp-zero").setup()
    require("mason").setup()

    require("mason-lspconfig").setup_handlers {
        function(server_name)
            require "lspconfig"[server_name].setup {}
        end
    }

    require("mason-lspconfig").setup {
        ensure_installed = M.servers,
        automatic_installation = true,
    }
end

return M
