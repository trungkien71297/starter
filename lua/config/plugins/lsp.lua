-- ~/.config/nvim/lua/config/plugins/lsp.lua
-- LSP server definitions and enable list

vim.lsp.enable({
  'lua_ls',
  'dartls',
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
      -- Speed up analyzer by skipping generated/build directories.
      analysisExcludedFolders = {
        vim.fs.joinpath(vim.fn.getcwd(), 'build'),
        vim.fs.joinpath(vim.fn.getcwd(), '.dart_tool'),
        vim.fs.joinpath(vim.fn.getcwd(), '.fvm'),
        vim.fs.joinpath(vim.fn.getcwd(), 'android', '.gradle'),
        vim.fs.joinpath(vim.fn.getcwd(), 'ios', 'Pods'),
      },
      -- Only analyze projects that contain open files. Big win for monorepos
      -- and workspaces with many example apps.
      onlyAnalyzeProjectsWithOpenFiles = true,
    },
  },
})

-- LSP Attach: auto-format on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          -- Skip generated Dart files: they are large and slow to format,
          -- and reformatting them can fight code generators.
          local name = vim.api.nvim_buf_get_name(ev.buf)
          if name:match('%.g%.dart$') or name:match('%.freezed%.dart$') then
            return
          end
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
        desc = ('fmt:%s'):format(client.name),
      })
    end
  end,
})

