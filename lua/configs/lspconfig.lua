return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.csharp_ls.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.intelephense.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })

            local function opts(desc)
                return { buffer = bufnr, desc = "LSP " .. desc }
            end
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts "Hover")
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Implementations")
            vim.keymap.set("n", "gr", function()
                require("telescope.builtin").lsp_references()
            end, {})

            vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { noremap = true, silent = true })
            vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts "rename")

            local _border = "single"
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = _border,
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = _border,
            })

            vim.diagnostic.config({
                float = { border = _border },
            })

            local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
}
