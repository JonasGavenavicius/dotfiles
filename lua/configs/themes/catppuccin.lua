local M = { 
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe", -- mocha, macchiato, frappe, latte
      transparent_background = true, -- disables setting the background color.
      -- color_overrides = {
      --     mocha = {
      --       base = "#000000",
      --       mantle = "#000000",
      --       crust = "#000000",
      --     },
      -- },
      integrations = {
        alpha = true,
        cmp = true,
        lsp_trouble = false,
        dap = true,
        fzf = true,
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
          enabled = false,
          style = "nvchad"
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    })

    -- Setup must be called before loading the colorscheme
    vim.cmd.colorscheme("catppuccin")
  end
}

return M
