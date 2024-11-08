local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"}
}
M.config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
    end, { desc = 'Harpoon add file' })
    vim.keymap.set("n", "<leader>hl", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon list files' })

    vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
    end, { desc = 'Harpoon select 1 file' })
    vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
    end, { desc = 'Harpoon select 2 file' })
    vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
    end, { desc = 'Harpoon select 3 file' })
    vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
    end, { desc = 'Harpoon select 4 file' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function()
        harpoon:list():prev()
    end, { desc = 'Harpoon select prew file' })
    vim.keymap.set("n", "<leader>hn", function()
        harpoon:list():next()
    end, { desc = 'Harpoon select next file' })


    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end
 
    vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
        { desc = "Open harpoon window" })
    end

return M
