require "nvchad.options"

local vim = vim
local opt = vim.opt
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
--p
vim.diagnostic.config {
  virtual_text = {
    -- source = "always",  -- Or "if_many"
    prefix = "●", -- Could be '■', '▎', 'x'
  },
  severity_sort = true,
  float = {
    source = true, -- Or "if_many"
  },
}

vim.wo.number = true
vim.wo.relativenumber = true
opt.cursorcolumn = true

opt.laststatus = 3

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
