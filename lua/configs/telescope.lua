local M = 
{
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-fzf-native.nvim"
    },
    cmd = "Telescope",
    opts = {
        defaults = {
            prompt_prefix = "   ",
            selection_caret = " ",
            entry_prefix = " ",
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                },
                width = 0.87,
                height = 0.80,
            },
        },
    },
}

M.config = function(_, opts)
    local telescope = require("telescope")

    -- telescope.load_extension('fzf')

    telescope.setup(opts)

    local map = vim.keymap.set
    local builtin = require("telescope.builtin")
    
    -- Define individual mappings directly
    map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Live Grep" })
    map("n", "<C-f>",      builtin.live_grep, { desc = "Telescope: Live Grep" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
    map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })
    map("n", "<leader>gt", function() vim.cmd("Telescope git_status") end, { desc = "Telescope: Git Status" })
    
    -- LSP-related mappings
    map("n", "grr", builtin.lsp_references, { desc = "Telescope: LSP References" })
    map("n", "gri", builtin.lsp_implementations, { desc = "Telescope: LSP Implementations" })
    map("n", "gO", builtin.lsp_document_symbols, { desc = "Telescope: LSP Document Symbols" })
end

return M