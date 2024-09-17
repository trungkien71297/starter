vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

--[[
NEOVIM KEY NOTATION REFERENCE
=============================

Modifier Keys:
  <C-key>   = Ctrl + key    (e.g., <C-l> = Ctrl+L)
  <A-key>   = Alt + key     (e.g., <A-j> = Alt+J)
  <M-key>   = Meta + key    (same as Alt on most systems)
  <S-key>   = Shift + key   (e.g., <S-Tab> = Shift+Tab)
  <D-key>   = Cmd + key     (macOS only, e.g., <D-c> = Cmd+C)

Special Keys:
  <CR>      = Enter/Return
  <Tab>     = Tab key
  <Space>   = Spacebar
  <BS>      = Backspace
  <Del>     = Delete
  <Esc>     = Escape
  <Home>    = Home key
  <End>     = End key
  <PageUp>  = Page Up
  <PageDown>= Page Down
  <Insert>  = Insert key

Arrow Keys:
  <Up>, <Down>, <Left>, <Right>

Function Keys:
  <F1>, <F2>, ..., <F12>

Combinations:
  <C-S-j>   = Ctrl + Shift + J
  <C-A-l>   = Ctrl + Alt + L
  <A-S-Tab> = Alt + Shift + Tab

Leader Key:
  <leader>  = Whatever you've set as leader (here it's Space)
  <leader>cp = Leader + c + p (Space + c + p)

Mode Prefixes in Keymaps:
  "n" = Normal mode
  "i" = Insert mode  
  "v" = Visual mode
  "x" = Visual block mode
  "t" = Terminal mode
  "c" = Command mode

Example:
  vim.keymap.set("i", "<C-l>", action)  -- Insert mode, Ctrl+L
  vim.keymap.set("n", "<leader>ff", action)  -- Normal mode, Space+f+f
--]]

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
