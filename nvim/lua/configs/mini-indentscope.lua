local M = {
    "echasnovski/mini.indentscope",
    version = "*", -- Stable
    event = "BufReadPre",
    config = function()
      require('mini.indentscope').setup({
        symbol = '│', -- or '▏', '▕', customize as you like
        options = {
          try_as_border = true,
        },
        draw = {
          delay = 50, -- <<-- animation speed in milliseconds
          animation = require('mini.indentscope').gen_animation.quadratic({
            easing = 'out',
            duration = 10, -- <<-- how fast the animation ends
          }),
        },
      })
    end,
  }

return M