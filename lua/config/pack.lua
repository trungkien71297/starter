-- ~/.config/nvim/lua/config/pack.lua
-- Plugin management using vim.pack (Neovim 0.11+ built-in package manager)
-- and plugin configurations with detailed comments

-- ============================================================================
-- PLUGIN LIST
-- ============================================================================
--
-- fzf-lua:           Fuzzy finder for files, grep, buffers, etc. (replaces telescope)
-- neoscroll:         Smooth scrolling animations
-- nvim-dap:          Debug Adapter Protocol - debugging support
-- oil.nvim:          File explorer that edits filesystem like a buffer
-- lazygit.nvim:      Terminal UI for git (lazygit integration)
-- codediff.nvim:     VSCode-like diff viewer
-- alpha-nvim:        Customizable start screen/dashboard
-- kanagawa.nvim:     Colorscheme inspired by Japanese ink painting
-- render-markdown:   Better markdown rendering in Neovim
-- nvim-web-devicons: File type icons for various plugins
-- lualine.nvim:      Status line (bottom bar) customization
-- gitsigns.nvim:     Git decorations in sign column (added/removed lines)
-- nvim-autopairs:    Auto-close brackets, quotes, etc.
-- trouble.nvim:      Pretty diagnostics list and LSP references
-- indent-blankline:  Visual indent guides
-- auto-session:      Automatically save/restore workspace sessions
-- blink.cmp:         Fast autocompletion engine with fuzzy matching

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',                          -- Fuzzy finder
  'https://github.com/karb94/neoscroll.nvim',                     -- Smooth scrolling
  'https://github.com/mfussenegger/nvim-dap',                     -- Debug Adapter Protocol
  'https://github.com/stevearc/oil.nvim',                         -- File explorer
  'https://github.com/kdheepak/lazygit.nvim',                     -- Git TUI integration
  'https://github.com/esmuellert/codediff.nvim',                  -- VSCode-like diffs
  'https://github.com/goolord/alpha-nvim',                        -- Start screen
  'https://github.com/rebelot/kanagawa.nvim',                     -- Colorscheme
  'https://github.com/MeanderingProgrammer/render-markdown.nvim', -- Markdown rendering
  'https://github.com/nvim-tree/nvim-web-devicons',               -- File icons
  'https://github.com/nvim-lualine/lualine.nvim',                 -- Status line
  'https://github.com/lewis6991/gitsigns.nvim',                   -- Git signs in gutter
  'https://github.com/windwp/nvim-autopairs',                     -- Auto-close pairs
  'https://github.com/folke/trouble.nvim',                        -- Diagnostics list
  'https://github.com/lukas-reineke/indent-blankline.nvim',       -- Indent guides
  'https://github.com/rmagatti/auto-session',                     -- Session management
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.x') -- Pin version for rust binary auto-download
  },
})

-- Built-in plugins (Neovim 0.11+)
vim.cmd.packadd('nvim.undotree') -- Visual undo tree (<leader>u)
vim.cmd.packadd('nvim.difftool') -- Enhanced diff tool

-- ============================================================================
-- PLUGIN CONFIGURATIONS
-- ============================================================================

-- ---------------------------------------------------------------------------
-- KANAGAWA - Colorscheme
-- ---------------------------------------------------------------------------
-- Japanese-inspired dark theme with beautiful color palette
-- Features: Wave, Dragon, and Lotus variants
require('kanagawa').setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none" -- Transparent gutter background
        }
      }
    }
  }
})
vim.cmd('colorscheme kanagawa')

-- ---------------------------------------------------------------------------
-- FZF-LUA - Fuzzy Finder
-- ---------------------------------------------------------------------------
-- Fast fuzzy finder for files, text, buffers, git, etc.
-- Written in Lua with fzf as backend
-- Keybindings: <leader><leader> (files), <leader>/ (grep), <leader>fb (buffers)
require('fzf-lua').setup({
  keymap = {
    builtin = {
      ["<C-d>"] = 'preview-page-down', -- Scroll preview down
      ["<C-u>"] = 'preview-page-up',   -- Scroll preview up
    },
  },
  fzf_opts = {
    ['--layout'] = 'reverse', -- Reverse layout (search at top)
  },
  actions = {
    files = {
      ['default'] = require('fzf-lua').actions.file_edit,
      ['ctrl-t'] = require('trouble.sources.fzf').open, -- Open in Trouble
    },
  },
})

-- ---------------------------------------------------------------------------
-- BLINK.CMP - Autocompletion
-- ---------------------------------------------------------------------------
-- Fast completion engine with fuzzy matching
-- Supports LSP, snippets, buffer, path sources
-- Keybindings: <C-j>/<C-k> (navigate), <CR> (accept), <Tab> (snippet)
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'fallback', 'accept' },
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
  },
})

-- ---------------------------------------------------------------------------
-- LUALINE - Status Line
-- ---------------------------------------------------------------------------
-- Customizable status bar showing mode, git, diagnostics, filename, etc.
-- Integrates with: gitsigns, diagnostics, trouble
require('lualine').setup({
  options = {
    theme = 'kanagawa',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },                          -- NORMAL, INSERT, etc.
    lualine_b = { 'branch', 'diff', 'diagnostics' }, -- Git and LSP info
    lualine_c = {
      {
        -- Show current symbol from Trouble when open
        function()
          return require('trouble').statusline({
            mode = 'symbols',
            groups = {},
            title = false,
            filter = { range = true },
            format = '{kind_icon}{symbol.name:Normal}',
            hl_group = 'lualine_c_normal',
          })
        end,
        cond = function()
          return package.loaded.trouble and require('trouble').is_open()
        end,
      },
      { 'filename', path = 1 }, -- Show relative path
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' }, -- Line percentage
    lualine_z = { 'location' }, -- Line:Column
  },
})

-- ---------------------------------------------------------------------------
-- GITSIGNS - Git Integration
-- ---------------------------------------------------------------------------
-- Shows git changes in the sign column (gutter)
-- Features: Added (+), Changed (~), Deleted (-) indicators
-- Also supports: blame, hunk preview, stage/reset hunks
require('gitsigns').setup({})

-- ---------------------------------------------------------------------------
-- NVIM-AUTOPAIRS - Auto-close Brackets
-- ---------------------------------------------------------------------------
-- Automatically closes brackets, quotes, parentheses
-- Example: Type `(` → automatically adds `)` and places cursor inside
require('nvim-autopairs').setup({})

-- ---------------------------------------------------------------------------
-- TROUBLE - Diagnostics List
-- ---------------------------------------------------------------------------
-- Pretty list for diagnostics, references, telescope results, quickfix
-- Replaces default quickfix window with better UI
require('trouble').setup({
  focus = true, -- Focus trouble when opened
})


-- ---------------------------------------------------------------------------
-- INDENT-BLANKLINE - Indent Guides
-- ---------------------------------------------------------------------------
-- Shows vertical lines for indentation levels
-- Also highlights current scope (function, if block, etc.)
require('ibl').setup({
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    injected_languages = false,
    highlight = { 'Function', 'Label' },
    priority = 500,
  },
  exclude = {
    filetypes = {
      'help', 'alpha', 'dashboard', 'neo-tree',
      'Trouble', 'trouble', 'lazy', 'mason',
      'notify', 'toggleterm', 'lazyterm',
    },
    buftypes = { 'terminal', 'nofile' },
  },
})

-- ---------------------------------------------------------------------------
-- AUTO-SESSION - Session Management
-- ---------------------------------------------------------------------------
-- Automatically saves and restores your workspace
-- Reopens all files and layout when you restart Neovim
require('auto-session').setup({
  suppressed_dirs = { '~/', '~/Downloads', '/', '/tmp' },
})
-- ---------------------------------------------------------------------------
-- OIL.NVIM - File Explorer
-- ---------------------------------------------------------------------------
-- Edit your filesystem like a buffer
-- Navigate with `-` (parent dir) or edit directly
-- Supports: rename, move, copy, delete like text operations
require('oil').setup({
  view_options = {
    show_hidden = true, -- Show dotfiles
  },
  keymaps = {
    ["<Esc>"] = "actions.close",
    ["q"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["<C-h>"] = "actions.refresh", -- Reuse refresh since window-nav <C-h> is unmapped
  },
})

-- ---------------------------------------------------------------------------
-- NEOSCROLL - Smooth Scrolling
-- ---------------------------------------------------------------------------
-- Animated smooth scrolling for Ctrl-D, Ctrl-U, zz, etc.
require('neoscroll').setup({
  hide_cursor = false,
  stop_eof = true,
  easing = 'quadratic',
  duration_multiplier = 0.30,
})

-- ---------------------------------------------------------------------------
-- CODEDIFF - VSCode-like Diffs
-- ---------------------------------------------------------------------------
-- Better diff viewing with side-by-side comparison
require('codediff').setup({})

-- ---------------------------------------------------------------------------
-- ALPHA-NVIM - Start Screen
-- ---------------------------------------------------------------------------
-- Customizable dashboard on startup
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = vim.split(
  [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡿⠈⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢶⣶⣴⣶⣤⣤⣾⠃⠀⠸⣷⣤⣤⣤⣤⣤⡴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣦⣄⠀⠀⠀⠀⠀⠀⢀⣠⡶⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢙⣷⠀⠀⠀⠀⠰⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⣼⠃⢀⣴⣶⣤⡀⢹⣇⠀⠀⠀⠀⠀⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣠⣶⠟⠁⠀⠀⠀⠀⠀⢰⣿⡶⠟⠁⠀⠉⠻⣶⣿⡀⠀⠀⠀⠀⠀⠹⣷⣤⢄⡀⠀⠀⠀⠀
⠀⠀⠀⢀⣼⢻⡿⣫⠀⠀⠀⠀⠀⠀⠀⠟⠋⠀⠀⠀⡀⠀⠀⠀⠙⠷⠀⠀⠀⠀⠀⠀⢿⣿⣧⣷⣄⡀⠀⠀
⠀⠀⣰⢹⣟⣽⡾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣽⡏⢳⡀⠀
⠀⢀⣿⢸⡿⣫⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣀⣀⠀⠀⠀⠙⢿⣦⡄⠀⠀⠀⠀⠀⠀⠈⣯⡿⣇⢸⡇⠀
⠀⡜⣿⢸⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⡿⠋⠀⠀⠀⠀⠈⢻⣿⣦⠀⠀⠀⠀⠀⠀⠘⣿⣮⢸⡟⡄
⢰⡇⢿⣿⢻⠆⠀⠀⠀⠀⠀⠀⠀⢴⣿⣿⡿⣿⣦⡀⠀⠀⠀⠀⠀⠀⢻⣿⣧⠀⠀⠀⠀⠀⠀⣯⢻⣿⢡⡇
⠘⣿⡘⢣⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠋⠀⠈⠻⣿⣦⡀⠀⠀⠀⠀⢸⣿⣿⡄⠀⠀⠀⠀⠀⢹⣧⠛⣾⡇
⢰⢿⣷⣼⡏⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣦⡀⠀⠀⣸⣿⣿⠇⠀⠀⠀⠀⠀⡞⣿⣾⡿⢱
⠘⣧⡻⣿⢰⣧⠀⠀⠀⠀⠀⠀⠀⠀⣠⣄⡀⠀⠀⠀⠀⠈⠻⣿⣦⣠⣿⣿⡿⠀⠀⠀⠀⠀⢰⣇⢸⠟⣰⡏
⠀⠹⣷⣌⢸⣿⢠⡀⠀⠀⠀⠀⢀⣼⡿⠙⠿⣿⣶⣦⣤⣤⣤⣼⣿⣿⣿⡟⠁⠀⠀⠀⠀⣰⢺⡿⣨⣾⠟⠀
⠀⠀⢯⠻⣿⣿⡈⣷⡀⠀⢠⣾⣿⠋⠀⠀⠀⠀⠉⠛⠻⠿⠿⠿⠿⠛⢿⣿⣦⡄⠀⠀⣸⡇⣼⣿⠟⣩⠂⠀
⠀⠀⠈⢿⣦⣙⡷⢻⣷⢦⡈⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠋⠀⣠⢶⣿⢑⣋⣴⡾⠋⠀⠀
⠀⠀⠀⠀⠉⡿⢿⣾⣿⣯⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⢣⣿⣿⡿⢟⡏⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠳⣶⣬⣭⣥⣽⣿⣦⡤⠄⣀⣀⣀⣀⣀⣀⣀⣀⣀⡤⣴⣾⣿⣥⣭⣤⣶⠾⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠻⣭⣉⣉⣡⣴⣾⡿⠟⣩⡶⠋⠉⠳⣮⣙⠿⣿⣶⣤⣭⣭⣭⠿⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⢴⠟⠁⠀⠀⠀⠀⠀⠙⣷⠄⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

  ]], '\n', { trimempty = true })
dashboard.section.header.opts.hl = 'Comment'
dashboard.section.buttons.val = {}
dashboard.section.footer.val = 'Nguyen Trung Kien'
dashboard.section.footer.opts.hl = 'Comment'
alpha.setup(dashboard.opts)

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

-- Lua Language Server - Lua development
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } }, -- Recognize vim global
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Dart Language Server - Flutter/Dart development
vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

-- Enable LSPs
vim.lsp.enable({
  'lua_ls',
  'dartls'
})

-- Global LSP keybinding (not buffer-local)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- ============================================================================
-- DEBUG (nvim-dap) - Python Configuration
-- ============================================================================

local dap = require('dap')

-- debugpy adapter for Python debugging
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

-- Python launch configuration
dap.configurations.python = {
  {
    type = 'debugpy',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    python = function()
      local root = vim.fs.root(0, '.venv')
      return { root and root .. '/.venv/bin/python' or 'python3' }
    end,
    cwd = function()
      return vim.fs.root(0, '.venv') or vim.fn.getcwd()
    end,
  },
}
