-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocommands (automated actions on events)

-- Highlight yanks - briefly highlight text when yanked
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.hl_op() end,
})
