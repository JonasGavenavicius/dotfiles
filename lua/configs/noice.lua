return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                top_down = true,
            },
        },
        "rcarriga/nvim-notify",
    },
    keys = {
        { "<leader>n",  "",                         desc = "Noice" },
        { "<leader>nd", "<cmd>Noice dismiss<cr>",   desc = "Dismiss all visible messages" },
        { "<leader>nn", "<cmd>Noice<cr>",           desc = "Open Noice" },
        { "<leader>ne", "<cmd>Noice errors<cr>",    desc = "Open Noice Errors" },
        { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "Open Noice with telescope" },
    },
    config = function()
        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        })
    end,
}
