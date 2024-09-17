return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Disable default tab mapping to avoid conflicts
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Disable copilot for non-code buffers and generated files
    vim.g.copilot_filetypes = {
      ["*"] = true,
      ["TelescopePrompt"] = false,
      ["neo-tree"] = false,
      ["NvimTree"] = false,
      ["lazy"] = false,
      ["mason"] = false,
      ["qf"] = false,
      ["help"] = false,
      ["gitcommit"] = false,
      ["gitrebase"] = false,
      ["hgcommit"] = false,
      ["svn"] = false,
      ["cvs"] = false,
      ["DressingInput"] = false,
      ["notify"] = false,
      ["noice"] = false,
    }

    -- Skip generated Dart files to reduce Copilot overhead
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*.g.dart", "*.freezed.dart", "*.gr.dart" },
      callback = function()
        vim.b.copilot_enabled = false
      end,
    })

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
