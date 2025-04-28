return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function(_, opts)
    local oil = require("oil")
    oil.setup({
      default_file_explorer = true,
    })

    -- Optional: Configure keymaps
    local map = vim.keymap.set
    map("n", "-", function() oil.open_float() end, { desc = "Open parent directory" })
    map("n", "<leader>ee", function() oil.open_float() end, { desc = "Oil Open parent directory" })
  end,
}
