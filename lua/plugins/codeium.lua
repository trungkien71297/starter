return {
  "Exafunction/codeium.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup {
      enabled = false,
      opts = {
        enable_chat = true,
      },
    }

    local cmp = require "cmp"
    local config = cmp.get_config()
    table.insert(config.sources, { name = "codeium" })
  end,
}
