require "nvchad.options"

local opt = vim.opt

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
  },
  severity_sort = true,
  float = {
    source = true,
  },
}

vim.wo.number = true
vim.wo.relativenumber = true
opt.cursorcolumn = true
opt.laststatus = 3

opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""

opt.shada = "'20,<50,s10,h"
