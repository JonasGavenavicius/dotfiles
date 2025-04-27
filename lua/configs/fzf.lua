return {
    "junegunn/fzf.vim",
    dependencies = { "nvim-lua/plenary.nvim" },  -- fzf depends on plenary
    cmd = { "Files", "Buffers", "Rg", "History", "GitFiles" },
}