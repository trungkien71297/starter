-- ~/.config/nvim/init.lua
-- Main configuration loader

vim.loader.enable()

require('vim._core.ui2').enable({})
require('config.options')     -- Vim options and settings
require('config.pack')        -- Plugin management and setup
require('config.keymaps')     -- Keybindings
require('config.diagnostics') -- Diagnostic configuration
require('config.autocmds')    -- Autocommands
require('custom.transparent').setup({ auto_enable = true })
