-- ~/.config/nvim/lua/config/diagnostics.lua
-- Diagnostic configuration and display settings

vim.diagnostic.config({
  severity_sort = true,           -- Show most severe error first
  update_in_insert = false,       -- Don't update while typing
  float = { source = 'if_many' }, -- Nicer look for floats, show source if multiple sources
  jump = { float = true },        -- Automatically open diagnostic float when jumping
})
