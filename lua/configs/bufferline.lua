local M = {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config =
        function()
            local bufferline = require('bufferline')
            vim.opt.termguicolors = true
            bufferline.setup {
                options = {
                    offsets = {
                        {
                            filetype = "NvimTree",
                            text = "Nvim Tree",
                            separator = true,
                            text_align = "left"
                        }
                    },
                    modified_icon = '●',
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    diagnostics = "nvim_lsp",
                    custom_areas = {
                        right = function()
                            local result = {}
                            local seve = vim.diagnostic.severity
                            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
                            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
                            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
                            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

                            if error ~= 0 then
                                table.insert(result, { text = "  " .. error, fg = "#EC5241" })
                            end

                            if warning ~= 0 then
                                table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
                            end

                            if hint ~= 0 then
                                table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
                            end

                            if info ~= 0 then
                                table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
                            end
                            return result
                        end,
                    }
                }
            }
        end
}
return M
