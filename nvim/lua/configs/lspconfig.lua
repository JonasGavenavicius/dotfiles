return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = function(desc)
          return { buffer = bufnr, desc = "LSP: " .. desc }
        end
        vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts("Code Action"))
        vim.keymap.set("n", "grl", function()
          vim.diagnostic.setloclist()
          vim.cmd("lopen")
        end, { desc = "Open File Diagnostics (Loclist)" })

        local border = "rounded"

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = border,
        })
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
          { border = border })
      end

      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            check = { command = "clippy" },
          },
        },
      })

      -- lspconfig.ruby_lsp.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   mason = false,
      --   cmd = { "mise", "x", "--", "ruby-lsp" },
      --   filetypes = { "ruby" },
      --   root_dir = util.root_pattern("Gemfile", ".git"),
      -- })

      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "ruby-lsp" },
        filetypes = { "ruby" },
        root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
      })
    end,
  },
}
