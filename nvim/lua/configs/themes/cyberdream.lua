return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      borderless_pickers = true,
      extensions = {
        alpha = true,
        lazy = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        whichkey = true,
        markdown = true,
        snacks = true,
      },
    })
    -- Add a custom keybinding to toggle the colorscheme

    vim.cmd("colorscheme cyberdream")
    vim.api.nvim_set_keymap("n", "<leader>ot", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })
  end,
}
