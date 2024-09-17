return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  lazy = false,
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode_cmd = "opencode --port"
    local snacks_terminal_opts = {
      win = {
        position = "float",
        enter = true,
        on_win = function(win)
          -- Set up keymaps and cleanup for an arbitrary terminal
          require("opencode.terminal").setup(win.win)
        end,
      },
    }
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts):close()
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    vim.keymap.set({ "n" }, "<leader>,a", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })
    vim.keymap.set({ "n" }, "<leader>,x", function()
      require("opencode").select()
    end, { desc = "Execute opencode action" })
    vim.keymap.set({ "n" }, "<leader>,t", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n" }, "go", function()
      return require("opencode").operator "@this "
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator "@this " .. "_"
    end, { desc = "Add line to opencode", expr = true })
  end,
}
