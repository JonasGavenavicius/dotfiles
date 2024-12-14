local M = {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lazy_status = require("lazy.status")
    require("lualine").setup({
      theme = "catppuccin",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          {
            -- Custom component for codeowners
            function()
              local codeowners = require("codeowners")
              return codeowners.whoBufname(vim.fn.bufname('%'))
            end,
            color = { fg = '#ff9e64', gui = 'bold' }, -- Customize text color and style
          }, 
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#f7768e" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "fzf", "lazy", "mason", "nvim-dap-ui", "trouble" },
    })
  end,
}

return M
