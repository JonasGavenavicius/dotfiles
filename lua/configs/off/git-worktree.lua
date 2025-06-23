local M = {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}

M.config = function()
  require("lua.configs.off.git-worktree").setup()
  require("telescope").load_extension("git_worktree")

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  map("n", "<leader>gwc", "<cmd>lua require('git-worktree').create_worktree(vim.fn.input('Branch: '), vim.fn.input('Path: '), vim.fn.input('Upstream (optional): '))<CR>", 
    { noremap = true, silent = true, desc = "Create Git Worktree" })

  map("n", "<leader>gws", "<cmd>lua require('git-worktree').switch_worktree(vim.fn.input('Path: '))<CR>", 
    { noremap = true, silent = true, desc = "Switch Git Worktree" })

  map("n", "<leader>gwd", "<cmd>lua require('git-worktree').delete_worktree(vim.fn.input('Path: '))<CR>", 
    { noremap = true, silent = true, desc = "Delete Git Worktree" })

end

return M
