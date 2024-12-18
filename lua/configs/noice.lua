return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>n",  "",                         desc = "Noice" },
        { "<leader>nd", "<cmd>Noice dismiss<cr>",   desc = "Dismiss all visible messages" },
        { "<leader>nn", "<cmd>Noice<cr>",           desc = "Open Noice" },
        { "<leader>ne", "<cmd>Noice errors<cr>",    desc = "Open Noice Errors" },
        { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "Open Noice with telescope" },
    },
    config = function()
        require("noice").setup {
            lsp = {
                hover = {
                    enabled = false, -- this will disable hover warning
                },
                signature = {
                    enabled = false, -- this will disable signtature warning.
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
                message = {
                    -- Messages shown by lsp servers
                    enabled = false,
                    view = "popup",
                    opts = {},
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        }
        vim.cmd([[
            hi NotifyBackground guibg=#000000 guifg=#ffffff blend=20
        ]])
    end,
}
