local M = {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'nvim-lua/plenary.nvim',
        "jay-babu/mason-nvim-dap.nvim",
    },
}

M.servers = {
    "lua_ls",
    "jsonls",
    "terraformls",
    -- "ruby_lsp",
    -- "rubocop",
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

    require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" }
      })
end

return M
