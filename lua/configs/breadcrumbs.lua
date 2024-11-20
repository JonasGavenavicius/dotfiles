local M = {
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
        { "SmiteshP/nvim-navic" },
    },
}

M.config = function()
    require("breadcrumbs").setup()
end

return M
