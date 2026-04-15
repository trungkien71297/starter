-- ~/.config/nvim/lua/config/options.lua
-- Vim options, settings, and global variables
vim.g.netrw_banner = 0     -- Hide netrw help banner in file explorer
vim.g.mapleader = ' '      -- Global leader key used by keymaps
vim.g.maplocalleader = ' ' -- Local leader key for buffer/filetype maps

-- Tab settings (2 spaces instead of default 8)
vim.o.tabstop = 2                                            -- Display width of a literal <Tab> character
vim.o.shiftwidth = 2                                         -- Indent width used by >>, <<, and autoindent
vim.o.softtabstop = 2                                        -- Spaces inserted/deleted when pressing <Tab>/<BS>
vim.o.expandtab = true                                       -- Convert tabs to spaces
vim.o.smartindent = true                                     -- Enable simple smart auto-indentation
vim.opt.wrap = false                                         -- Disable line wrapping for long lines
vim.o.undofile = true                                        -- Keep undo history after closing files
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"       -- Save undo files in Neovim data directory
vim.o.relativenumber = true                                  -- Show relative numbers on non-current lines
vim.o.number = true                                          -- Show absolute number on the current line
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"        -- Configure completion popup behavior
vim.opt.shortmess:append("c")                                -- Avoid extra completion messages
vim.opt.scrolloff = 8                                        -- Keep cursor away from top/bottom edges
vim.opt.sidescrolloff = 8                                    -- Keep cursor away from left/right edges
vim.o.ignorecase = true                                      -- Case-insensitive search
vim.o.smartcase = true                                       -- Case-sensitive if uppercase present
vim.o.hlsearch = true                                        -- Highlight search results
vim.opt.iskeyword:append("-")                                -- Treat '-' as part of a word (foo-bar is one word)
vim.opt.path:append("**")                                    -- :find searches subfolders recursively
vim.opt.wildmode = "longest:full,full"                       -- Smarter : command-line completion
vim.opt.wildignore:append({ "*/node_modules/*", "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
vim.opt.inccommand = "split"                                 -- Show :substitute preview in split window
vim.opt.splitbelow = true                                    -- Open horizontal splits below current window
vim.opt.splitright = true                                    -- Open vertical splits to the right
vim.opt.laststatus = 3                                       -- Use one global statusline for all windows
vim.opt.swapfile = false                                     -- Disable swap file creation
vim.opt.backup = false                                       -- Disable backup file creation
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end) -- Use system clipboard (+ register)

-- UI settings
vim.o.confirm = true      -- Raise dialog on unsaved buffer close
vim.o.signcolumn = 'yes'  -- Keep sign column visible (no jumping)
vim.opt.colorcolumn = "0" -- Disable color column marker
-- Fold settings
vim.o.foldmethod = 'expr' -- Compute folds from expression/provider (e.g. treesitter)
vim.o.foldlevel = 99      -- Keep folds open by default for deep nesting
vim.o.foldlevelstart = 99 -- Start with folds opened when file loads
vim.o.foldcolumn = '1'    -- Always reserve 1 column to display fold markers
vim.opt.updatetime = 250  -- Faster update events (CursorHold, diagnostics refresh)

vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10
vim.o.winborder = "rounded"
vim.o.pumheight = 12
vim.o.pumblend = 10       -- Slightly transparent completion menu
vim.o.cmdheight = 0
vim.o.showmatch = true    -- Briefly flash the matching bracket
vim.o.matchtime = 2       -- ...for 2 tenths of a second
vim.o.title = true        -- Show the file name in the terminal tab title
vim.o.writebackup = false
vim.opt.fillchars:append({ diff = "╱" }) -- Diagonal fill in empty diff areas
vim.opt.messagesopt:append('maxheight:50,timeout:4000,pager:g<') -- ui2 pager height and message timeout
