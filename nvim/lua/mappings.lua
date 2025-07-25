local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Git integrations
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git Diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git File History" })
map("n", "<leader>gld", "<cmd>Gitsigns toggle_word_diff<cr>", { desc = "Gitsigns: Toggle Word Diff" })

-- LSP / Buffer
map("n", "grb", function()
    vim.lsp.buf.format()
end, { desc = "Format current buffer" })

-- Copy relative file path
map("n", "<leader>lf", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    print("Copied: " .. path)
end, { desc = "Copy relative file path to clipboard" })

-- Helper: interactive string replace
local function replace_cmd(scope, confirm)
    return function()
        vim.ui.input(
        { prompt = "Find string" .. (scope ~= "%" and " (global)" or "") .. (confirm and "" or " (no confirm)") .. ": " },
            function(source)
                if not source or source == "" then return end
                vim.ui.input({ prompt = "Replace with: " }, function(target)
                    if not target then return end
                    source = vim.fn.escape(source, "/\\")
                    target = vim.fn.escape(target, "\\&")
                    local flags = confirm and "gc" or "g"
                    local cmd = (scope == "%") and string.format("%%s/%s/%s/%s", source, target, flags)
                        or string.format("argdo %%s/%s/%s/%s | update", source, target, flags)
                    vim.cmd(cmd)
                end)
            end)
    end
end

-- Replace mappings
map("n", "<leader>rS", replace_cmd("%", false), { desc = "Replace in buffer (no confirm)" })
map("n", "<leader>rs", replace_cmd("%", true), { desc = "Replace in buffer (confirm each)" })
map("n", "<leader>rG", replace_cmd("argdo", false), { desc = "Replace in all args (no confirm)" })
map("n", "<leader>rg", replace_cmd("argdo", true), { desc = "Replace in all args (confirm each)" })
