local opt = vim.opt
local g = vim.g

-- GENERAL -------------------------------------------------------------------

g.mapleader = " " -- Set <leader> key to space
g.toggle_theme_icon = "   " -- Custom global var for UI (used in statusline, etc.)

opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal

-- UI ------------------------------------------------------------------------

opt.cursorline = true         -- Highlight current line
opt.laststatus = 3            -- Global statusline (one bar across all splits)
opt.showmode = false          -- Hide mode like -- INSERT -- (plugin usually handles it)
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers (helps with movement)
opt.numberwidth = 2           -- Width of number column
opt.ruler = false             -- Don't show ruler (cursor position) in command line
opt.signcolumn = "yes"        -- Always show sign column
opt.cursorline = true         -- Highlight current line
opt.cursorlineopt = "number"  -- Only highlight the number column
opt.fillchars = { eob = " " } -- Remove ~ from end-of-buffer lines
opt.winborder = "rounded"     -- Use rounded borders (for floating windows etc.)
opt.wrap = false              -- Disable line wrapping
opt.mouse = "a"               -- Enable mouse in all modes
opt.scrolloff = 10            -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8         -- Keep 8 columns left/right of cursor

-- STARTUP -------------------------------------------------------------------

opt.shortmess:append("sI") -- Disable startup intro message

-- INDENTATION ---------------------------------------------------------------

opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftwidth = 2     -- Number of spaces to use for indentation
opt.tabstop = 2        -- Width of a tab character
opt.softtabstop = 2    -- Number of spaces for tab key
opt.smartindent = true -- Enable smart indentation
opt.autoindent = true  -- Copy indent from current line

-- SEARCH --------------------------------------------------------------------

opt.ignorecase = true -- Ignore case in search by default
opt.smartcase = true  -- ...unless uppercase used in search term
opt.incsearch = true  -- Show search matches as you type

-- NAVIGATION ----------------------------------------------------------------

opt.splitright = true          -- Vertical splits open to the right
opt.splitbelow = true          -- Horizontal splits open below
opt.timeoutlen = 400           -- Time to wait for mapped sequence (ms)
opt.whichwrap:append("<>[]hl") -- Allow left/right arrow and h/l to wrap lines

-- FILE HANDLING -------------------------------------------------------------

opt.clipboard = "unnamedplus" -- Use system clipboard for yank/paste
opt.undofile = true           -- Enable persistent undo
opt.autoread = true           -- Reload file if changed outside of nvim
opt.autowrite = false         -- Don’t auto-save on buffer switch
opt.updatetime = 250          -- Time before swap/diagnostics are triggered

-- PERFORMANCE --------------------------------------------------------------
opt.redrawtime = 10000     -- Allow up to 10s to render/redraw heavy buffers
opt.maxmempattern = 20000  -- Allow up to 20MB for regex/syntax pattern matching

-- DIAGNOSTICS ---------------------------------------------------------------

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '', -- Error sign
            [vim.diagnostic.severity.WARN]  = '', -- Warning sign
            [vim.diagnostic.severity.HINT]  = '󰌵', -- Hint sign
            [vim.diagnostic.severity.INFO]  = '', -- Info sign
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg', -- Line highlight on error
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg', -- Number column highlight on warning
        },
    },
    underline = true,         -- Underline diagnostics
    update_in_insert = false, -- Don’t update diagnostics while typing
    severity_sort = true,     -- Sort diagnostics by severity
    virtual_lines = {
        current_line = true,  -- Only show virtual diagnostic lines on the current line
    },
})
