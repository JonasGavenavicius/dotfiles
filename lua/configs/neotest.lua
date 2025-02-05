local M = {
    "nvim-neotest/neotest",
    dependencies = {
        "olimorris/neotest-rspec",     -- RSpec adapter
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-rspec"),
            },
        })
    end,
}

return M
