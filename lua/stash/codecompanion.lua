return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = function()
    require("codecompanion").setup {
      display = {
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            border = "single",
            height = 0.8,
            width = 0.45,
            relative = "editor",
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
          intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
          show_settings = true,
          show_token_count = true,
          start_in_insert_mode = false,
          separator = "─",
          show_header_separator = true,
          header = {
            separator = "─",
            align = "center",
          },
        },
      },
      strategies = {
        chat = {
          adapter = "gemini",
        },
        inline = {
          adapter = "gemini",
        },
        agent = {
          adapter = "gemini",
        },
      },

      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = os.getenv "GEMINI_API_KEY",
            },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = os.getenv "ANTHROPIC_API_KEY",
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = "",
            },
          })
        end,
        llama3 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "llama3.2:latest",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
        deepseek = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "deepseek-r1", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "deepseek-r1:14b",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
      },
      vim.keymap.set("n", "<leader>cc", "<cmd>Telescope codecompanion<CR>"),
      vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
    }
  end,
}
