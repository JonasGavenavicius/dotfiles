local M = {
    "akinsho/toggleterm.nvim",
    version = "*",
}

M.config = function()
    require("toggleterm").setup({
        direction = "float",
        float_opts = {
            border = "curved",
            width = 120,
            height = 30,
            winblend = 3,
        },
        open_mapping = [[<c-\>]],
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
    })

  function RunNearestTestInTerminal()
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".")
    local cmd = "bundle exec rspec " .. file .. ":" .. line

    if test_term == nil then
      local Terminal = require("toggleterm.terminal").Terminal
      test_term = Terminal:new({
        cmd = cmd,
        direction = "float",
        on_exit = function() test_term = nil end,
      })
    else
      test_term.cmd = cmd
    end

    test_term:toggle()
  end

  vim.keymap.set("n", "<leader>trn", RunNearestTestInTerminal, { desc = "Run nearest ruby test in terminal" })
end

return M
