local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Runners
    "nvim-neotest/neotest-jest",
    "rouge8/neotest-rust",
    "nvim-neotest/neotest-vim-test",
    "fredrikaverpil/neotest-golang",
    "olimorris/neotest-rspec",
  },
  config = function()
    require("config.cfg_neotest")
  end,
}

M.config = function ()
  local neotest = require("neotest")
  neotest.setup({
    adapters = {
      require("neotest-jest"),
      -- require('rustaceanvim.neotest'),
      require("neotest-rust"),
      require("neotest-vim-test")({
        ignore_file_types = { "python", "vim", "lua" },
      }),
      require("neotest-golang"),
      require("neotest-rspec")({
        rspec_cmd = function()
          return vim.tbl_flatten({ "bundle", "exec", "rspec" })
        end
      }),
    },
    icons = {
      child_indent = "│",
      child_prefix = "├",
      collapsed = "─",
      expanded = "╮",
      failed = "❌",
      final_child_indent = " ",
      final_child_prefix = "╰",
      non_collapsible = "─",
      notify = "🔔",
      passed = "🟩",
      running = "󰜎",
      running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
      skipped = "󰒭",
      unknown = "!",
      watching = "󰈈",
    },
  })

  vim.keymap.set("n", "<leader>trk", function()
    vim.fn.jobstart({ "pkill", "-f", "rspec" }, {
      on_exit = function()
        print("Killed all rspec processes.")
      end,
    })
  end, { desc = "Kill all running RSpec tests" })
end

M.keys = {
  { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
  { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Run nearest test debug" },
  -- { "<leader>t/", function() require("neotest").run.run({strategy = toggleterm_strategy}) end, desc = "Run nearest test toggleterm" },
  { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
  { "<leader>ta", function() require("neotest").run.run({ suite = true }) end, desc = "Run test suite" },
  { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
  { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test" },
  { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
  { "<leader>tt", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
}

return M
