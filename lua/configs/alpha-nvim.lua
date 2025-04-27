local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- icons for dashboard
    config = function()
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
    end
  }

  return M