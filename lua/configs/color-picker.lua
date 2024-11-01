return {
    "exosyphon/telescope-color-picker.nvim",
    config = function()
        vim.keymap.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", { desc = "Telescope Color Picker" })
    end,
}
