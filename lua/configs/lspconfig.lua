require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "dartls",
  "pylsp",
  "fish_lsp",
  "fish_lsp",
  "gradle_ls",
  "groovyls",
  "jsonls",
  "kotlin_language_server",
  "kotlin_lsp",
  "lua_ls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
