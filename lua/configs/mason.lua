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
    "ruby_lsp",
    -- "rubocop",
    "ts_ls",
    "gopls",
}

function M.config()
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
