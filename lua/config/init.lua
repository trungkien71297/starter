-- ~/.config/nvim/lua/config/init.lua
-- Main configuration loader - requires all submodules in order

require('config.options')      -- Vim options and settings
require('config.pack')         -- Plugin management and setup
require('config.keymaps')      -- Keybindings
require('config.diagnostics')  -- Diagnostic configuration
require('config.autocmds')     -- Autocommands
