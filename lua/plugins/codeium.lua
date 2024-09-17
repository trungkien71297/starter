return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  config = function()
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set("i", "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-;", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-,>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true })

    vim.g.codeium_winsurf_enabled = 1
    vim.g.codeium_winsurf_auto_trigger = 1
    vim.g.codeium_winsurf_debounce_delay = 75
    vim.g.codeium_winsurf_max_suggestions = 3
    vim.g.codeium_winsurf_priority = "high"
  end,
}
