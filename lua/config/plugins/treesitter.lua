-- ~/.config/nvim/lua/config/plugins/treesitter.lua
-- Treesitter syntax highlighting and folding (built-in in Nvim 0.13)

local group = vim.api.nvim_create_augroup('treesitter.start', { clear = true })

-- Treesitter-based folding. 'foldmethod' is already set to 'expr' in options.lua.
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Start treesitter highlighting for every buffer that has an installed parser.
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
