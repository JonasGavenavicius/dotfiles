return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            local enabled_features = {
                "documentSymbols",
                "documentLink",
                "hover",
                "foldingRanges",
                "selectionRanges",
                -- "semanticHighlighting",
                -- "formatting",
                "onTypeFormatting",
                -- "diagnostics",
                "codeActions",
                "documentHighlights",
                "inlayHint",
                "completion",
                "codeLens",
                "definition",
                "workspaceSymbol",
                "signatureHelp",
            }

            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.csharp_ls.setup({ capabilities = capabilities })
            lspconfig.clangd.setup({ capabilities = capabilities })
            lspconfig.intelephense.setup({ capabilities = capabilities })
            lspconfig.pyright.setup({ capabilities = capabilities })
            lspconfig.ts_ls.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.ruby_lsp.setup(
                {
                    -- mason = false,
                    -- cmd = { "mise", "x", "--", "ruby-lsp" },
                    mason = false,
                    cmd = { "mise", "x", "--", "ruby-lsp" },
                    filetypes = { "ruby" },
                    root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
                    -- cmd = { os.getenv("HOME") .. "/.rbenv/shims/ruby-lsp" },
                    -- filetypes = { "ruby" },
                    -- root_dir = util.root_pattern("Gemfile", ".git"),
                    init_options = {
                        enabledFeatures = enabled_features,
                    },
                    settings = {},
                })
            lspconfig.rubocop.setup(
                {
                    cmd = { "bundle", "exec", "rubocop", "--lsp" },
                    filetypes = { "ruby" },
                    root_dir = util.root_pattern("Gemfile", ".git"),
                })

            local function opts(desc)
                return { buffer = bufnr, desc = "LSP " .. desc }
            end
            --vim.keymap.set("n", "gD", require("telescope.builtin").lsp_declarations, opts "Go to declaration")
            --vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts "Go to definition")
            --vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts "Go to implementation")
            --vim.keymap.set("n", "gi", require("telescope.builtin").lsp_type_definitions, opts "Go to type definition")
            --vim.keymap.set("n", "K", vim.lsp.buf.hover, opts "Hover")
            --vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
            --vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts "References")
            --
            --vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { noremap = true, silent = true })
            --vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { noremap = true, silent = true })
            --vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts "rename")
            --
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
        opts = {
            inlay_hints = { enabled = true },
        }
    },
}
