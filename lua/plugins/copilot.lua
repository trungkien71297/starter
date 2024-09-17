return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default tab mapping to avoid conflicts
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Enable copilot for specific filetypes
    vim.g.copilot_filetypes = {
      ["*"] = false,
      python = true,
      javascript = true,
      typescript = true,
      javascriptreact = true,
      typescriptreact = true,
      lua = true,
      go = true,
      rust = true,
      cpp = true,
      c = true,
      java = true,
      php = true,
      ruby = true,
      vim = true,
      sh = true,
      zsh = true,
      bash = true,
      markdown = true,
      json = true,
      yaml = true,
      toml = true,
      html = true,
      css = true,
      scss = true,
      dart = true,
      kt = true,
      cs = true,
    }

    -- Custom keymaps for copilot
    local opts = { silent = true, noremap = true }

    -- Accept suggestion
    vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })

    -- Navigate through suggestions
    vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", opts)
    vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", opts)

    -- Dismiss suggestion
    vim.keymap.set("i", "<C-h>", "<Plug>(copilot-dismiss)", opts)

    -- Toggle copilot
    vim.keymap.set("n", "<leader>cp", ":Copilot panel<CR>", opts)
    vim.keymap.set("n", "<leader>ct", ":Copilot toggle<CR>", opts)
  end,
}
