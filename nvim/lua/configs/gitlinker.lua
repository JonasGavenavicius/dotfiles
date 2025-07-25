return {
  "linrongbin16/gitlinker.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("gitlinker").setup()
  end,
  keys = {
    { "<leader>gy", "<cmd>GitLink<CR>", desc = "Copy GitHub link to current line" },
    { "<leader>gb", "<cmd>GitLink!<CR>", desc = "Open GitHub link in browser" },
  },
}
