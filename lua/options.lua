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
opt.foldlevel = 1 -- Fold function bodies (level 1 = fold functions, higher levels stay open)
opt.foldlevelstart = 1 -- Start with function bodies folded
opt.foldenable = true -- Enable folding

-- Limit shada to prevent loading too many old buffers
-- '0 = no marks, <0 = no registers, f0 = no file marks, :0 = no cmdline history
opt.shada = "'20,<50,s10,h"
