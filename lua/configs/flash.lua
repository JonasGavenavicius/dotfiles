return {
    ",",
    function()
        local seen_labels = {}
        require("flash").jump({
            highlight = { backdrop = false },
            search = { max_length = 0 },
            label = { before = true, after = false, style = "overlay" },
            labeler = function() end,
            matcher = function(win)
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.b[buf].neo_tree_source ~= "buffers" then return {} end
                return vim
                    .iter(vim.api.nvim_buf_get_extmarks(buf, -1, 0, -1, { details = true }))
                    :filter(function(e)
                        local hl = e[4].hl_group
                        return hl == "NeoTreeFileName" or hl == "NeoTreeGitModified"
                    end)
                    :map(function(e)
                        local start_row, start_col, end_row, end_col = e[2], e[3], e[4].end_row, e[4].end_col
                        local fname = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})[1]
                        local label
                        local i = 1
                        while i <= #fname do
                            label = fname:sub(i, i)
                            if label:match("%w") and not seen_labels[label] then
                                seen_labels[label] = true
                                break
                            end
                            i = i + 1
                        end
                        return {
                            pos = { start_row + 1, start_col + i },
                            label = label,
                        }
                    end)
                    :totable()
            end,
            action = function(match)
                vim.api.nvim_win_call(match.win, function()
                    vim.api.nvim_win_set_cursor(match.win, match.pos)
                    vim.cmd.execute('"normal \\<CR>"')
                end)
            end,
        })
    end,
    desc = "Pick buffers",
}
