local M = {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v1.x",
    dependencies = {
        -- LSP support
        'neovim/nvim-lspconfig',

        -- Autocompletetion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',

        -- Snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
}

M.config = function()
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts "Hover")
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "Implementations")
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references()
    end, {})

    vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { noremap = true, silent = true })
    vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts "rename")
end

return M
