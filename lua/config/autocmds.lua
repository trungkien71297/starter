-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocommands (automated actions on events)

-- Highlight yanks - briefly highlight text when yanked
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- LSP Attach: buffer-local keymaps and auto-format on save
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- LSP keybindings (respecting Nvim 0.11 defaults: grn, grc, gri, grr, gra)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover documentation' })
    -- Note: <leader>f for format is defined globally in keymaps.lua

    -- Auto-format ("lint") on save
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil"
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
        desc = ('fmt:%s'):format(client.name),
      })
    end
  end,
})
