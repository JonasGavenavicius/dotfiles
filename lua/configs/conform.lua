local M = {
    "stevearc/conform.nvim",
}

M.config = function()
    local conform = require("conform")
    conform.setup({
        options = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                go = { "gofumpt", "goimports", "goimports-reviser" },
                terraform = { "terraform_fmt" },
                python = { "isort", "black" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = true,
                timeout_ms = 1000,
            },
        }
    })
end

return M
