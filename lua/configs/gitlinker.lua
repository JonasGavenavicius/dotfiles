return {
  "linrongbin16/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitlinker").setup()

    vim.keymap.set("n", "<leader>gy", function()
      require("gitlinker").get_buf_range_url("n")
    end, { desc = "GitHub link to line (copy)" })

    vim.keymap.set("v", "<leader>gy", function()
      require("gitlinker").get_buf_range_url("v")
    end, { desc = "GitHub link to selection (copy)" })

    vim.keymap.set("n", "<leader>gb", function()
      require("gitlinker").get_buf_range_url("n", {
        action_callback = require("gitlinker.actions").open_in_browser,
      })
    end, { desc = "GitHub line open in browser" })

    vim.keymap.set("v", "<leader>gb", function()
      require("gitlinker").get_buf_range_url("v", {
        action_callback = require("gitlinker.actions").open_in_browser,
      })
    end, { desc = "GitHub selection open in browser" })
  end,
}
