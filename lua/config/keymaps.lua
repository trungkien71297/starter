-- ~/.config/nvim/lua/config/keymaps.lua
-- Keybindings and shortcuts grouped by feature

local map = vim.keymap.set -- Local helper for shorter keymap definitions

-- Leader key cheat sheet
-- <leader><BS>  : Alternate file
-- <leader>-     : Oil (float)
-- <leader><leader> : Find files (FzfLua)
-- <leader>/     : Live grep (FzfLua)
-- <leader>bd/bn/bp/bl : Buffer delete/next/prev/list
-- <leader>cf    : Format code
-- <leader>D     : Line diagnostics popup
-- <leader>dd    : Delete without yanking
-- <leader>db/dc/dq/dr/dl/dh/ds : Debug controls
-- <leader>fb/fh/fr : Fzf buffers/help/recent
-- <leader>ft     : Find TODO comments (FzfLua)
-- <leader>g     : Lazygit
-- ]t/[t         : Next/previous TODO comment
-- <leader>sj/sJ/sr : Flash jump/treesitter/remote
-- <leader>xt    : Todo list (Trouble)
-- <leader>u     : Undotree toggle
-- <leader>xx/xs/xl/xq : Trouble diagnostics/symbols/lsp/qflist

-- Floating/popup-first keymaps:
-- <leader>D      : Line diagnostics float
-- <leader>ca     : Code actions (FzfLua)
-- <leader><leader>/<leader>/ : FzfLua files/grep
-- <leader>fb/fh/fr/ft : FzfLua buffers/help/recent/TODO
-- <leader>-      : Oil floating explorer
-- <leader>dh/ds  : DAP hover/scopes floats

-- -----------------------------------------------------------------------------
-- Core editing and navigation
-- -----------------------------------------------------------------------------
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' }) -- Clear active search highlight quickly
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })    -- Focus left split
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })   -- Focus right split
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })   -- Focus lower split
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })   -- Focus upper split
map('n', '<leader><BS>', '<C-^>', { desc = 'Switch to alternate file' })       -- Toggle current file and previous file

-- Keep selection when changing indent in visual mode
map('v', '<', '<gv', { desc = 'Unindent and keep selection' }) -- Shift left and reselect text
map('v', '>', '>gv', { desc = 'Indent and keep selection' })   -- Shift right and reselect text

-- Cursor-friendly movement and search navigation
map('n', 'J', 'mzJ`z', { desc = 'Join lines without moving cursor' })     -- Join line and preserve cursor/view position
map('n', '<C-d>', '<C-d>zz', { desc = 'Move down with cursor centered' }) -- Half-page down and center cursor
map('n', '<C-u>', '<C-u>zz', { desc = 'Move up with cursor centered' })   -- Half-page up and center cursor
map('n', 'n', 'nzzzv', { desc = 'Next search result centered' })          -- Go to next match and center
map('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })      -- Go to previous match and center

-- -----------------------------------------------------------------------------
-- Buffers and editing helpers
-- -----------------------------------------------------------------------------
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })      -- Close current buffer
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })          -- Go to next buffer
map('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })  -- Go to previous buffer
map('n', '<leader>bl', '<cmd>buffers<cr>', { desc = 'List buffers' })       -- Show full buffer list
map({ 'n', 'v' }, '<leader>dd', '"_d', { desc = 'Delete without yanking' }) -- Delete into black-hole register
map('n', '<leader>u', '<cmd>Undotree<cr>', { desc = 'Toggle Undotree' })    -- Toggle undo history tree panel

-- -----------------------------------------------------------------------------
-- LSP and diagnostics
-- -----------------------------------------------------------------------------
map('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostics' }) -- Open diagnostics float for current line
map('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>', { desc = 'Code actions (FzfLua)' }) -- Open floating code action picker
map('n', '<leader>uh', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' }) -- Toggle LSP inlay hints on/off
-- Format code (works before/without buffer-local LspAttach mappings)
map({ 'n', 'v' }, '<leader>cf', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 }) -- LSP clients attached to current buffer
  local has_formatter = false                        -- Track whether formatting is supported

  for _, client in ipairs(clients) do
    if client:supports_method('textDocument/formatting') then
      has_formatter = true -- At least one formatter exists
      break
    end
  end

  if has_formatter then
    vim.lsp.buf.format({ timeout_ms = 2000 })                                     -- Run LSP formatting with timeout
  else
    vim.notify('No LSP formatter available for this buffer', vim.log.levels.WARN) -- Notify when formatter is missing
  end
end, { desc = 'Format code' })

-- LSP mappings set in LspAttach autocmd:
-- gd, <leader>ca, <leader>rn, K, gi, gr

-- -----------------------------------------------------------------------------
-- Search and discovery
-- -----------------------------------------------------------------------------
map('n', '<leader><leader>', '<cmd>FzfLua files<cr>', { desc = 'Find files' })     -- Open file picker
map('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Find live grep' })    -- Search project text with ripgrep
map('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Find buffers' })       -- Pick open buffer
map('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = 'Find help' })        -- Search help tags
map('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Find recent files' }) -- Open recent file list
map('n', '<leader>ft', '<cmd>TodoFzfLua<cr>', { desc = 'Find TODO comments' })     -- Show TODO/FIX comments in FzfLua
map('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next TODO comment' }) -- Jump to next TODO-style comment
map('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous TODO comment' }) -- Jump to previous TODO-style comment

-- -----------------------------------------------------------------------------
-- Flash navigation
-- -----------------------------------------------------------------------------
map({ 'n', 'x', 'o' }, '<leader>sj', function()
  require('flash').jump()
end, { desc = 'Flash jump' })
map({ 'n', 'x', 'o' }, '<leader>sJ', function()
  require('flash').treesitter()
end, { desc = 'Flash treesitter' })
map('o', '<leader>sr', function()
  require('flash').remote()
end, { desc = 'Flash remote' })

-- -----------------------------------------------------------------------------
-- File explorer and git
-- -----------------------------------------------------------------------------
map('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })                       -- Open Oil in current window
map('n', '<leader>-', '<cmd>Oil --float<cr>', { desc = 'Open oil in floating window' }) -- Open Oil in floating window
map('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })                          -- Open Lazygit TUI

-- Git signs (gitsigns)
local gs = require('gitsigns')
map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, { desc = 'Blame line' })  -- Blame the line under cursor
map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })            -- Inline blame for current line
map('n', '<leader>gs', gs.stage_buffer, { desc = 'Stage buffer' })                              -- Stage all changes in buffer
map('n', '<leader>gh', gs.stage_hunk, { desc = 'Stage hunk' })                                  -- Stage hunk under cursor
map('n', '<leader>gu', gs.reset_hunk, { desc = 'Reset hunk' })                                  -- Undo hunk under cursor
map('n', ']c', function() gs.nav_hunk('next') end, { desc = 'Next hunk' })                      -- Jump to next hunk
map('n', '[c', function() gs.nav_hunk('prev') end, { desc = 'Previous hunk' })                  -- Jump to previous hunk

-- Diff view (codediff)
map('n', '<leader>dv', '<cmd>CodeDiff<cr>', { desc = 'Diff view' })                             -- Side-by-side diff workspace
map('n', '<leader>dH', '<cmd>CodeDiff history<cr>', { desc = 'Repo history' })                  -- Browse repository history

-- -----------------------------------------------------------------------------
-- Debugging (nvim-dap)
-- -----------------------------------------------------------------------------
map('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Debug toggle breakpoint' }) -- Toggle breakpoint at cursor
map('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Debug continue' })                   -- Start/continue debug session
map('n', '<leader>dq', function() require('dap').terminate() end, { desc = 'Debug terminate' })                 -- Stop debug session
map('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'Debug open REPL' })                 -- Open DAP REPL
map('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Debug run last' })                   -- Re-run previous debug config
map({ 'n', 'v' }, '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'Debug hover' })     -- Inspect value under cursor
map('n', '<leader>ds', function()
  require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)                                               -- Show scope variables
end, { desc = 'Debug scopes' })
map('n', '<Down>', function() require('dap').step_over() end, { desc = 'Debug step over' })      -- Execute current line and stop on next line
map('n', '<Right>', function() require('dap').step_into() end, { desc = 'Debug step into' })     -- Enter called function
map('n', '<Left>', function() require('dap').step_out() end, { desc = 'Debug step out' })         -- Run until leaving current function
map('n', '<Up>', function() require('dap').restart_frame() end, { desc = 'Debug restart frame' }) -- Restart current stack frame

-- -----------------------------------------------------------------------------
-- Trouble list
-- -----------------------------------------------------------------------------
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics (Trouble)' })          -- Toggle diagnostics list
map('n', '<leader>xs', '<cmd>Trouble symbols toggle<cr>', { desc = 'Symbols (Trouble)' })                  -- Toggle symbols list
map('n', '<leader>xl', '<cmd>Trouble lsp toggle<cr>', { desc = 'LSP Definitions / references (Trouble)' }) -- Toggle LSP locations list
map('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })             -- Toggle quickfix in Trouble
map('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { desc = 'TODO list (Trouble)' })                            -- Show TODO/FIX comments in Trouble

-- -----------------------------------------------------------------------------
-- Agent coding helpers (copy paths/selection for AI agents)
-- -----------------------------------------------------------------------------
local function copy(text)
  vim.fn.setreg('+', text)
  vim.notify('Copied: ' .. text, vim.log.levels.INFO)
end

map('n', '<leader>yf', function()
  local rel = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  copy(('%s#L%d'):format(rel, vim.fn.line('.')))
end, { desc = 'Copy relative path#Lline' })

map('n', '<leader>yp', function()
  copy(('%s#L%d'):format(vim.api.nvim_buf_get_name(0), vim.fn.line('.')))
end, { desc = 'Copy absolute path#Lline' })

map('x', '<leader>cc', function()
  local start = vim.fn.line("'<")
  local stop = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start - 1, stop, false)
  local ft = vim.bo.filetype
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
  local fence = string.rep(string.char(96), 3)
  copy(('%s%s filename="%s" line=%d\n%s\n%s'):format(fence, ft, name, start, table.concat(lines, '\n'), fence))
end, { desc = 'Copy selection as Markdown code block' })
