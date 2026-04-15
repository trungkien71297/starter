-- ~/.config/nvim/lua/config/plugins/tools.lua
-- Editing, navigation, git, diagnostics, and debug tooling

require('fzf-lua').setup({
  keymap = {
    builtin = {
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
  fzf_opts = {
    ['--layout'] = 'reverse',
  },
  actions = {
    files = {
      ['default'] = require('fzf-lua').actions.file_edit,
      ['ctrl-t'] = require('trouble.sources.fzf').open,
    },
  },
})

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'fallback', 'accept' },
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
  },
  appearance = { use_nvim_cmp_as_default = false, nerd_font_variant = 'mono' },
  completion = { ghost_text = { enabled = true } },
})

require('gitsigns').setup({})
require('nvim-autopairs').setup({})
require('nvim-surround').setup({})

require('todo-comments').setup({
  signs = true,
  highlight = {
    keyword = 'wide',
    after = 'fg',
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
  },
})

require('flash').setup({
  labels = 'asdfghjklqwertyuiopzxcvbnm',
  search = {
    multi_window = true,
  },
  jump = {
    nohlsearch = true,
  },
  modes = {
    char = {
      enabled = false,
    },
  },
})

require('trouble').setup({
  focus = true,
})

require('oil').setup({
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<Esc>'] = 'actions.close',
    ['q'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['<C-h>'] = 'actions.refresh',
  },
})

require('neoscroll').setup({
  hide_cursor = false,
  stop_eof = true,
  easing = 'quadratic',
  duration_multiplier = 0.30,
})

require('codediff').setup({})

local dap = require('dap')

dap.adapters.debugpy = function(cb, config)
  if config.request == 'attach' then
    cb({
      type = 'server',
      port = config.connect.port,
      host = config.connect.host or '127.0.0.1',
    })
  else
    cb({
      type = 'executable',
      command = 'debugpy-adapter',
    })
  end
end

dap.configurations.python = {
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    python = function()
      local root = vim.fs.root(0, '.venv')
      return root and root .. '/.venv/bin/python' or 'python3'
    end,
    cwd = function()
      return vim.fs.root(0, '.venv') or vim.fn.getcwd()
    end,
  },
}

-- Formatting (conform): Lua via stylua; Dart keeps the existing LSP format-on-save
require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  format_on_save = {
    timeout_ms = 1000,
  },
})
