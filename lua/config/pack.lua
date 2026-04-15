-- ~/.config/nvim/lua/config/pack.lua
-- Plugin installation and module loading

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/karb94/neoscroll.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/kdheepak/lazygit.nvim',
  'https://github.com/esmuellert/codediff.nvim',
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/stevearc/conform.nvim',
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.x'),
  },
})

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require('config.plugins.ui')
require('config.plugins.tools')
require('config.plugins.lsp')
require('config.plugins.treesitter')
