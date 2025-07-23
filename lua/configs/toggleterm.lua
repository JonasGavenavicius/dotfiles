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
end

return M
