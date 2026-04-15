-- ~/.config/nvim/lua/config/options.lua
-- Vim options, settings, and global variables

-- Set <space> as leader (must happen before other plugins loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Tab settings (2 spaces instead of default 8)
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- Persistent undo - save undo history between sessions
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data') .. '/undo'
vim.fn.mkdir(vim.fn.stdpath('data') .. '/undo', 'p')

-- Relative line numbers with absolute on current line
vim.o.relativenumber = true
vim.o.number = true

-- Search settings
vim.o.ignorecase = true       -- Case-insensitive search
vim.o.smartcase = true        -- Case-sensitive if uppercase present
vim.o.hlsearch = true         -- Highlight search results

-- Sync vim and system clipboards
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- UI settings
vim.o.confirm = true          -- Raise dialog on unsaved buffer close
vim.o.ttimeoutlen = 1         -- Snappy escape
vim.o.signcolumn = 'yes'      -- Keep sign column visible (no jumping)
