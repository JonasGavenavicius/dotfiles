local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "nvim-telescope/telescope-ui-select.nvim" },
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
            mappings = {
                n = {
                    ["q"] = function()
                        local actions = require("telescope.actions")
                        actions.close()
                    end
                },
            },
        },

        extensions = {},
    },
}
M.extensions = {
    ["ui-select"] = {
        {

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
        }
    }
}

M.config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension("ui-select")
    local map = vim.keymap.set
    local builtin = require('telescope.builtin')
    map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
end

return M
