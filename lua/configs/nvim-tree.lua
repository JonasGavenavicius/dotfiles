local M = {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
    config = function()
        require("nvim-tree").setup({
            view = {
              width = 60,
            },
            renderer = {
              group_empty = true,
            },
            filters = {
              dotfiles = false,
            },
            update_focused_file = {
              enable = true,
              update_cwd = false, -- (optional) set to true if you want to update Neovim's cwd too
              ignore_list = {},
            },
          })
  
      vim.keymap.set('n', '<leader>el', ':NvimTreeToggle<CR>', { desc = "Toggle nvim-tree file explorer" })
    end,
  }

return M
