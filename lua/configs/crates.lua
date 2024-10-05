-- Setup for go.nvim
local M = {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function()
        require("crates").setup {
            completion = {
                cmp = {
                    enabled = true
                },
            },
        }
    end
}

return M
