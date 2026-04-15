-- ~/.config/nvim/lua/config/plugins/ui.lua
-- UI-oriented plugin configuration

require('kanagawa').setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
})
vim.cmd('colorscheme kanagawa')

require('lualine').setup({
  options = {
    theme = 'kanagawa',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
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
      { 'filename', path = 1 },
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

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

  ]],
  '\n',
  { trimempty = true }
)
dashboard.section.header.opts.hl = 'Comment'
-- dashboard.section.buttons.val = {}
dashboard.section.footer.val = 'Nguyen Trung Kien'
dashboard.section.footer.opts.hl = 'Comment'
alpha.setup(dashboard.opts)

require('which-key').setup({})

require('render-markdown').setup({})
