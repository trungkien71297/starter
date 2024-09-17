local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    dart = { "dart_format" }, -- New: For Flutter
    go = { "gofmt" }, -- New: For Go
    gdscript = { "gdformat" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 10000,
    lsp_fallback = true,
  },
}

return options
