return {
  "NachoNievaG/atac.nvim",
  lazy = false,
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("atac").setup {
      dir = "~/Work", -- By default, the dir will be set as /tmp/atac
    }
  end,
}
