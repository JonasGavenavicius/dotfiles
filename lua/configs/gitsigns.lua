local M = {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      current_line_blame = true,  -- Show inline blame (author + timestamp)
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
      },
    }
  end
}

return M
