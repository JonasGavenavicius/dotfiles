return {
  "git-owners",
  dir = vim.fn.stdpath("config") .. "/lua/git-owners",
  config = function()
    require("git-owners").setup()
  end,
}

