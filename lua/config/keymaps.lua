-- ~/.config/nvim/lua/config/keymaps.lua
-- Keybindings and shortcuts

-- Clear search highlights with Escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick switch to alternate file (useful after opening oil)
vim.keymap.set('n', '<leader><BS>', '<C-^>', { desc = 'Switch to alternate file' })

-- Buffer management
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bl', '<cmd>buffers<cr>', { desc = 'List buffers' })

-- Diagnostics
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

-- Format code (global keymap - works even before LSP attaches)
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  -- Check if any LSP clients support formatting
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local has_formatter = false
  for _, client in ipairs(clients) do
    if client:supports_method('textDocument/formatting') then
      has_formatter = true
      break
    end
  end

  if has_formatter then
    vim.lsp.buf.format({ timeout_ms = 2000 })
  else
    vim.notify('No LSP formatter available for this buffer', vim.log.levels.WARN)
  end
end, { desc = 'Format code ' })

-- LSP (buffer-local, set in LspAttach autocmd)
-- gd - Go to definition (defined in pack.lua)
-- <leader>ca - Code action
-- <leader>rn - Rename symbol
-- K - Hover documentation
-- gi - Go to implementation
-- gr - Find references

-- FZF-Lua - Fuzzy finder integration
vim.keymap.set('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = 'Find help' })
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Find recent files' })

-- Oil.nvim - File explorer (buffer replacement)
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>-', '<CMD>Oil --float<CR>', { desc = 'Open oil in floating window' })

-- Lazygit - Git TUI
vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })

-- Debug (nvim-dap)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Debug continue' })
vim.keymap.set('n', '<leader>dq', function() require('dap').terminate() end, { desc = 'Debug terminate' })
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Debug open REPL' })
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Debug run last' })
vim.keymap.set({ 'n', 'v' }, '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug hover' })
vim.keymap.set('n', '<leader>ds', function()
  require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)
end, { desc = 'Debug scopes' })
vim.keymap.set('n', '<Down>', function() require('dap').step_over() end, { desc = 'Debug step over' })
vim.keymap.set('n', '<Right>', function() require('dap').step_into() end, { desc = 'Debug step into' })
vim.keymap.set('n', '<Left>', function() require('dap').step_out() end, { desc = 'Debug step out' })
vim.keymap.set('n', '<Up>', function() require('dap').restart_frame() end, { desc = 'Debug restart frame' })

-- Trouble - Diagnostics list
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle<cr>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle<cr>', { desc = 'LSP Definitions / references (Trouble)' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })
