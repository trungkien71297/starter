return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      -- config
      shortcut_type = "number",
      packages = { enable = true },
      config = {
        header = require "configs.dashboard_art",
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
