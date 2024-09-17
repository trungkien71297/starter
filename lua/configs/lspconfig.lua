-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
-- local servers = { "html", "cssls" }
local servers = { "html", "cssls", "dartls", "cmake", "sourcekit", "gopls", "clangd", "jsonls", "jsonnet_ls", "yamlls" }
local nvlsp = require "nvchad.configs.lspconfig"
-- EXAMPLE

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      nvlsp.on_attach(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
-- typescript
-- lspconfig.ts_ls.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
