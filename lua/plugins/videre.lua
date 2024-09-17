return {
  "Owen-Dechow/nvim_json_graph_view",
  lazy = false,
  dependencies = {
    "Owen-Dechow/graph_view_yaml_parser", -- Optional: add YAML support
  },
  opts = {
    -- set the window editor type
    editor_type = "floating", -- split, floating

    -- configure the floating window style
    floating_editor_style = {
      margin = 2,
      border = "double",
      zindex = 10,
    },

    -- Number of lines before collapsing
    max_lines = 5,

    -- Set the unit style to round
    round_units = true,

    -- Set the connection style to round
    round_connections = true,

    -- Disable line wrapping for the graph buffer
    disable_line_wrap = true,

    -- Set the priority of keymaps for the quick
    --   action keymap.
    keymap_priorities = {
      expand = 4,
      collapse = 2,
      link_forward = 3,
      link_backward = 3,
      set_as_root = 1,
    },

    -- Set the keys actions will be mapped to
    keymaps = {
      -- Expanding collapsed areas
      expand = "E",

      -- Collapse expanded areas
      collapse = "E",

      -- Jump to linked unit
      link_forward = "L",

      -- Jump back to unit parent
      link_backward = "B",

      -- Set current unit as root
      set_as_root = "R",

      -- Aliased to first priority available keymap
      quick_action = "<CR>",

      -- Close the window
      close_window = "q",
    },
  },
}
