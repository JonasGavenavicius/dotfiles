local M = {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- icons for dashboard
      "folke/snacks.nvim", -- for picker functionality
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                               ]],
        [[ Wake up, Neo...              ]],
        [[ The Matrix has you...        ]],
        [[ Follow the white rabbit.     ]],
        [[ Knock, knock, Neo.           ]],
        [[                               ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("r", "🔃  Resume Last Session", ":lua require('persistence').load({ last = true })<CR>"),
        dashboard.button("f", "🔎  Find file", ":lua require('snacks').picker.files()<CR>"),
        dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "🗂️  Find project", ":lua require('snacks').picker.recent()<CR>"),
        dashboard.button("l", "🛠️  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "🚪  Quit NVIM", ":qa<CR>"),
      }

      dashboard.section.footer.val = {
        "WAR IS PEACE | FREEDOM IS SLAVERY | IGNORANCE IS STRENGTH",
        "Big Brother is watching you...",
      }

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  }
}

return M
