local M = { "catppuccin/nvim", name = "catppuccin", priority = 1000 }

M.config = {
    function()
        require("catppuccin").setup({
            -- transparent_background = true, -- disables setting the background color.
            integrations = {
                cmp = true,
                lsp_trouble = true,
                dap = true,
                dap_ui = true,
                mason = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                which_key = true,
                harpoon = true,
                mini = {
                    enabled = false,
                    indentscope_color = "",
                },
                telescope = {
                  enabled = true,
                  style = "nvchad"
                }
            },
        })

        -- setup must be called before loading
        vim.cmd.colorscheme "catppuccin"
    end
}

return M
