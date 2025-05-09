local M = {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- icons for dashboard
      "stevearc/resession.nvim",
    },
    config = function()
      -- Setup resession first
      require("resession").setup({
        autosave = {
          enabled = true,
          interval = 60,     -- autosave every 60s
          notify = false,
          last = true,       -- <-- this is important
        },
      })

      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        " ",
        " ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
        " ████╗  ██║██║   ██║██║████╗ ████║",
        " ██╔██╗ ██║██║   ██║██║██╔████╔██║",
        " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
        " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
        " ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("r", "  Resume Last Session", ":lua require('resession').load('last')<CR>"),
        dashboard.button("f", "🔎  Find file", ":Telescope find_files<CR>"),
        dashboard.button("e", "📄  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "🗂️  Find project", ":Telescope projects<CR>"),
        dashboard.button("l", "🛠️  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "🚪  Quit NVIM", ":qa<CR>"),
      }

      dashboard.section.footer.val = {
        "🚀 Happy hacking with Neovim!",
      }

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  }
}

return M
