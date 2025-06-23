local M =
{
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "nvim-telescope/telescope-ui-select.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
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
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set

    -- Add <C-t> mapping inside Telescope
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
            i = {
                ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
                ["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
        },
    })

    telescope.setup(opts)

    -- Safe global keymaps (outside of Telescope UI)
    map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
    map("n", "<leader>fg", function()
      builtin.live_grep({
        additional_args = function()
          return { "--fixed-strings" }
        end,
      })
    end, { desc = "Telescope: Grep (Literal)" })
    map("n", "<leader>fr", builtin.live_grep, { desc = "Telescope: Regex Grep" })
    map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
    map("n", "<leader>fH", builtin.help_tags, { desc = "Telescope: Help Tags" })
    map("n", "<leader>gt", builtin.git_status, { desc = "Telescope: Git Status" })
    map("n", "<leader>gs", builtin.git_stash, { desc = "Telescope: Git Stash" })

    -- LSP-related mappings
    map("n", "grr", builtin.lsp_references, { desc = "Telescope: LSP References" })
    map("n", "gri", builtin.lsp_implementations, { desc = "Telescope: LSP Implementations" })
    map("n", "grh", builtin.lsp_document_symbols, { desc = "Telescope: LSP Document Symbols" })
    map("n", "grdd", builtin.lsp_definitions, { desc = "Telescope: LSP Definitions" })
    map("n", "grdt", builtin.lsp_type_definitions, { desc = "Telescope: LSP Type Definitions" })
    map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope: LSP Diagnostics" })
end

return M
