return {
  "petertriho/nvim-scrollbar",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "kevinhwang91/nvim-hlslens",
  },
  config = function()
    require("scrollbar").setup({
      show = true,
      set_highlights = true,
      handle = {
        text = " ",
        color = nil,
        color_nr = nil,
        highlight = "ScrollbarHandle",
      },
      marks = {
        Cursor = { text = "•", priority = 0 },
        Search = { text = { "-", "=" }, priority = 1, color = nil, highlight = "Search" },
        Error = { text = { "" }, priority = 2, highlight = "DiagnosticVirtualTextError" },
        Warn = { text = { "" }, priority = 3, highlight = "DiagnosticVirtualTextWarn" },
        Info = { text = { "" }, priority = 4, highlight = "DiagnosticVirtualTextInfo" },
        Hint = { text = { "" }, priority = 5, highlight = "DiagnosticVirtualTextHint" },
        Misc = { text = { "·" }, priority = 6 },
        GitAdd = { text = "│", highlight = "GitSignsAdd" },
        GitChange = { text = "│", highlight = "GitSignsChange" },
        GitDelete = { text = "_", highlight = "GitSignsDelete" },
      },
      handlers = {
        diagnostic = true,
        search = true,
        gitsigns = true,
        cursor = true,
        handle = true,
      },
    })

    require("scrollbar.handlers.search").setup()
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
