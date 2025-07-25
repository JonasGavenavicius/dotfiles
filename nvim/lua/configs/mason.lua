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
  "gopls",
  "rust_analyzer",
  "ruby_lsp"
}

function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup()

  require("mason-nvim-dap").setup({
    ensure_installed = { "codelldb" }
  })
end

return M
