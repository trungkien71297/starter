return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "dart",
        "yaml",
        "json",
        "markdown",
        "gdscript",
        "gdshader",
        "godot_resource",
      },
      fold = { enable = true },
      build = ":TSUpdate",
    },
  },
}
