return {
  "ruifm/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({
      mappings = nil, -- we'll set our own below
    })

    vim.keymap.set("n", "<leader>gl", function()
      require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").copy_to_clipboard })
    end, { desc = "Copy GitHub URL to clipboard" })
  end,
}


