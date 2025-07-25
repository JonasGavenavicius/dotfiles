local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {"nvim-lua/plenary.nvim"}
}
M.config = function()
  local harpoon = require("harpoon")
  local picker = require("snacks").picker

  harpoon:setup()

  local map = vim.keymap.set

  -- Core harpoon operations
  map("n", "<leader>ha", function()
    harpoon:list():add()
  end, { desc = 'Harpoon add file' })

  map("n", "<leader>hl", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = 'Harpoon list files' })

  -- Direct file selection
  map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = 'Harpoon select 1 file' })
  map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = 'Harpoon select 2 file' })
  map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = 'Harpoon select 3 file' })
  map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = 'Harpoon select 4 file' })
  map("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = 'Harpoon select 5 file' })
  map("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = 'Harpoon select 6 file' })
  map("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = 'Harpoon select 7 file' })
  map("n", "<leader>h8", function() harpoon:list():select(8) end, { desc = 'Harpoon select 8 file' })

  -- Navigation
  map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = 'Harpoon select prev file' })
  map("n", "<leader>hn", function() harpoon:list():next() end, { desc = 'Harpoon select next file' })

  -- Snacks picker for harpoon files
  map("n", "<leader>fh", function()
    local harpoon_files = harpoon:list()
    local items = {}

    for i, item in ipairs(harpoon_files.items) do
      if item.value and item.value ~= "" then
        table.insert(items, {
          text = string.format("[%d] %s", i, vim.fn.fnamemodify(item.value, ":~:.")),
          value = item.value,
          index = i
        })
      end
    end

    if #items == 0 then
      vim.notify("No harpoon files", vim.log.levels.WARN)
      return
    end

    picker.pick({
      title = "Harpoon Files",
      items = items,
      format = function(item) return item.text end,
      on_select = function(item)
        vim.cmd("edit " .. item.value)
      end
    })
  end, { desc = "Open harpoon picker" })
  -- basic telescope configuration
  -- local conf = require("telescope.config").values
  -- local function toggle_telescope(harpoon_files)
  --   local file_paths = {}
  --   for _, item in ipairs(harpoon_files.items) do
  --     table.insert(file_paths, item.value)
  --   end
  --
  --   require("telescope.pickers").new({}, {
  --     prompt_title = "Harpoon",
  --     finder = require("telescope.finders").new_table({
  --       results = file_paths,
  --     }),
  --     previewer = conf.file_previewer({}),
  --     sorter = conf.generic_sorter({}),
  --   }):find()
  -- end
  --
  -- vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
  --   { desc = "Open harpoon window" })

end

return M
