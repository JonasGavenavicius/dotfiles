local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git File History" })
map("n", "<leader>gld", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Gitsigns: Toggle Word Diff" })
map("n", "<leader>lf", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy relative file path to clipboard" })

vim.keymap.set("n", "<leader>rS", function()
  vim.ui.input({ prompt = "Find string: " }, function(source)
    if not source or source == "" then return end
    vim.ui.input({ prompt = "Replace with: " }, function(target)
      if not target then return end
      -- Escape slashes to avoid breaking the command
      source = vim.fn.escape(source, "/\\")
      target = vim.fn.escape(target, "\\&")
      -- Build and run the substitution command
      vim.cmd(string.format("%%s/%s/%s/g", source, target))
    end)
  end)
end, { desc = "Replace string in buffer (no confirm)" })

vim.keymap.set("n", "<leader>rs", function()
  vim.ui.input({ prompt = "Find string (buffer): " }, function(source)
    if not source or source == "" then return end
    vim.ui.input({ prompt = "Replace with: " }, function(target)
      if not target then return end
      source = vim.fn.escape(source, "/\\")
      target = vim.fn.escape(target, "\\&")
      vim.cmd(string.format("%%s/%s/%s/gc", source, target)) -- `c` = confirm
    end)
  end)
end, { desc = "Replace string in buffer (confirm each)" })

vim.keymap.set("n", "<leader>rG", function()
  vim.ui.input({ prompt = "Find string (global, no confirm): " }, function(source)
    if not source or source == "" then return end
    vim.ui.input({ prompt = "Replace with: " }, function(target)
      if not target then return end
      source = vim.fn.escape(source, "/\\")
      target = vim.fn.escape(target, "\\&")
      vim.cmd(string.format("argdo %%s/%s/%s/g | update", source, target)) -- no confirm
    end)
  end)
end, { desc = "Replace in all args files (no confirm)" })

vim.keymap.set("n", "<leader>rg", function()
  vim.ui.input({ prompt = "Find string (global): " }, function(source)
    if not source or source == "" then return end
    vim.ui.input({ prompt = "Replace with: " }, function(target)
      if not target then return end
      source = vim.fn.escape(source, "/\\")
      target = vim.fn.escape(target, "\\&")
      vim.cmd(string.format("argdo %s", string.format("%%s/%s/%s/gc | update", source, target)))
    end)
  end)
end, { desc = "Replace string in all args files (confirm each)" })

vim.keymap.set("n", "grb", function()
  vim.lsp.buf.format()
end, { desc = "Format current buffer" })
vim.keymap.set("n", "<C-k>", function()
  vim.lsp.buf.hover()
end, { desc = "LSP Hover" })
