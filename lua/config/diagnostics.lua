-- ~/.config/nvim/lua/config/diagnostics.lua
-- Diagnostic configuration and display settings

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●", source = "if_many" },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
})
