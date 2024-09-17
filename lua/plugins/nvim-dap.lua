return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    {
      "LiadOz/nvim-dap-repl-highlights",
      config = function()
        require("nvim-dap-repl-highlights").setup()
      end,
    },
    {
      "folke/lazydev.nvim",
      opts = function(_, opts)
        opts.library = opts.library or {}
        table.insert(opts.library, { plugins = { "nvim-dap-ui" }, types = true })
      end,
    },
  },
  keys = {
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "Breakpoint Condition",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>dC",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<leader>dg",
      function()
        require("dap").goto_()
      end,
      desc = "Go to Line (No Execute)",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>dj",
      function()
        require("dap").down()
      end,
      desc = "Down",
    },
    {
      "<leader>dk",
      function()
        require("dap").up()
      end,
      desc = "Up",
    },
    {
      "<leader>dl",
      function()
        require("dap").run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>do",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<leader>dO",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dP",
      function()
        require("dap").pause()
      end,
      desc = "Pause",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.toggle()
      end,
      desc = "Toggle REPL",
    },
    {
      "<leader>ds",
      function()
        require("dap").session()
      end,
      desc = "Session",
    },
    {
      "<leader>dt",
      function()
        require("dap").terminate()
      end,
      desc = "Terminate",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle {}
      end,
      desc = "Dap UI",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval()
      end,
      desc = "Eval",
      mode = { "n", "v" },
    },
    {
      "<leader>dd",
      function()
        require("dapui").float_element("scopes", { enter = true })
      end,
      desc = "Scopes Float",
    },
    {
      "<leader>df",
      function()
        require("dapui").float_element("stacks", { enter = true })
      end,
      desc = "Stacks Float",
    },
    {
      "<leader>dv",
      function()
        require("dapui").float_element("watches", { enter = true })
      end,
      desc = "Watches Float",
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Hover Variables",
      mode = { "n", "v" },
    },
    {
      "<leader>dp",
      function()
        require("dap.ui.widgets").preview()
      end,
      desc = "Preview Variable",
      mode = { "n", "v" },
    },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    require("mason-nvim-dap").setup {
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
        python = function(config)
          config.configurations = {
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              pythonPath = function()
                return vim.fn.getcwd() .. "/.venv/bin/python" or "/usr/bin/python3"
              end,
            },
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
      ensure_installed = {
        "delve",
        "python",
        "codelldb",
      },
    }

    dapui.setup {
      icons = {
        expanded = "▾",
        collapsed = "▸",
        current_frame = "*",
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.50 },
            { id = "breakpoints", size = 0.30 },
            { id = "stacks", size = 0.20 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
      render = {
        max_type_length = nil,
        max_value_lines = 100,
        indent = 1,
      },
    }

    require("nvim-dap-virtual-text").setup {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_frames = false,
      virt_lines = false,
      virt_text_pos = "eol",
      all_references = false,
    }

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "DapBreakpointCondition" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "⊘", texthl = "DapBreakpointRejected", linehl = "", numhl = "DapBreakpointRejected" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStopped" }
    )
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" })

    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f5a623" })
    vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#8a8a8a" })
    vim.api.nvim_set_hl(0, "DapStopped", { fg = "#73c991" })
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    dap.set_log_level "INFO"

    dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

    require("dap-go").setup {
      delve = {
        detached = vim.fn.has "win32" == 0,
      },
      dap_configurations = {
        {
          type = "go",
          name = "Debug File (Arguments)",
          request = "launch",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input "Args: "
            return vim.split(args_string, " +")
          end,
        },
      },
    }

    dap.adapters.dart = {
      type = "executable",
      command = "dart",
      args = { "debug_adapter" },
    }

    dap.adapters.flutter = {
      type = "executable",
      command = "flutter",
      args = { "debug_adapter" },
    }

    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch Dart",
        program = "${workspaceFolder}/bin/main.dart",
        cwd = "${workspaceFolder}",
      },
      {
        type = "dart",
        request = "launch",
        name = "Launch Dart File",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "flutter",
        request = "launch",
        name = "Launch Flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
      },
      {
        type = "flutter",
        request = "launch",
        name = "Launch Flutter (Profile)",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        toolArgs = { "--profile" },
      },
      {
        type = "flutter",
        request = "launch",
        name = "Launch Flutter (Custom Args)",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        toolArgs = function()
          local args = vim.fn.input "Flutter args: "
          return vim.split(args, " +")
        end,
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dart",
      callback = function()
        vim.keymap.set("n", "<leader>dfF", function()
          require("dap").continue()
        end, { buffer = true, desc = "Flutter: Debug" })
        vim.keymap.set("n", "<leader>dfl", function()
          require("dap").run_last()
        end, { buffer = true, desc = "Flutter: Debug Last" })
      end,
    })
  end,
}
