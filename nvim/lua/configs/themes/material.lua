local M = {
    "marko-cerovac/material.nvim",
    as = "material",
    config = function()
        -- Set the default style to deep ocean
        vim.g.material_style = "deep ocean"

        -- Set up the Material theme
        require('material').setup({
            contrast = {
                terminal = false,  -- Enable contrast for the built-in terminal
                sidebars = false,  -- Enable contrast for sidebar-like windows (e.g. Nvim-Tree)
                floating_windows = false,  -- Enable contrast for floating windows
                cursor_line = false,  -- Enable darker background for the cursor line
                lsp_virtual_text = false,  -- Enable contrasted background for LSP virtual text
                non_current_windows = false,  -- Enable contrasted background for non-current windows
                filetypes = {},  -- Specify which filetypes get the contrasted (darker) background
            },

            styles = {
                comments = { --[[ italic = true ]] },
                strings = { --[[ bold = true ]] },
                keywords = { --[[ underline = true ]] },
                functions = { --[[ bold = true, undercurl = true ]] },
                variables = {},
                operators = {},
                types = {},
            },

            plugins = {
                "dap",
                "gitsigns",
                "harpoon",
                "mini",
                "neotest",
                "nvim-cmp",
                "nvim-tree",
                "telescope",
                "trouble",
                "which-key",
                "nvim-notify",
            },

            disable = {
                colored_cursor = false,
                borders = false,
                background = false,
                term_colors = false,
                eob_lines = false
            },

            high_visibility = {
                lighter = false,
                darker = false
            },

            lualine_style = "default",  -- Can be 'stealth' or 'default'
            async_loading = true,  -- Load parts of the theme asynchronously for faster startup
            custom_colors = nil,  -- Override default colors (set to function)
            custom_highlights = {},  -- Overwrite highlights with your own
        })

        -- Set the colorscheme after the setup
        vim.cmd("colorscheme material")
    end,
}

return M