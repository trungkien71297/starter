require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  -- "dartls", 
  "pylsp",
  "fish_lsp",
  "gradle_ls",
  "groovyls",
  "jsonls",
  "kotlin_language_server",
  "lua_ls",
  "omnisharp",
  "gopls",
  "gdscript",
  "sourcekit",
}

local gdscript_port = tonumber(vim.env.GDScript_Port) or 6005

vim.lsp.config("gdscript", {
  cmd = vim.lsp.rpc.connect("127.0.0.1", gdscript_port),
  filetypes = { "gd", "gdscript", "gdscript3" },
  root_markers = { "project.godot" },
})

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
