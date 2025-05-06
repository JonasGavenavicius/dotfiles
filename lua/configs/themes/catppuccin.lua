local M = { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true, -- disables setting the background color.
            integrations = {
                cmp = true,
                lsp_trouble = false,
                dap = true,
                dap_ui = true,
                mason = true,
                nvimtree = true,
                neotest = true,
                gitsigns = true,
                copilot_vim = true,
                native_lsp = true,
                treesitter = true,
                notify = false,
                which_key = true,
                harpoon = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                telescope = {
                    enabled = true,
                    style = "nvchad"
                }
            },
        })

        -- Setup must be called before loading the colorscheme
        vim.cmd.colorscheme("catppuccin")
    end
}

return M
