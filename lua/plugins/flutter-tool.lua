return {
  "nvim-flutter/flutter-tools.nvim",
  ft = "dart",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    require("flutter-tools").setup {
      ui = {
        border = "rounded",
        notification_style = "native",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
          project_config = false,
        },
      },
      debugger = {
        enabled = true,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          local dap = require "dap"
          -- Clear the defaults added by register_default_configurations()
          -- (the default "Launch flutter" points to lib/main.dart at root,
          -- which fails for package projects that have no runnable app at root)
          dap.configurations.dart = {}
          local root = vim.fn.getcwd()
          for _, conf in ipairs(dap.configurations.dart or {}) do
            if conf.cwd and not vim.startswith(conf.cwd, "/") then
              conf.cwd = root .. "/" .. conf.cwd
            end
          end
          -- Fallback: if no launch.json found, add a default config
          if #(dap.configurations.dart or {}) == 0 then
            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch Flutter",
                dartSdkPath = paths.dart_sdk,
                flutterSdkPath = paths.flutter_sdk,
                program = "lib/main.dart",
                cwd = root,
              },
            }
          end
        end,
      },
      -- Use FVM - this is important for your setup
      fvm = true,
      root_patterns = { ".git", "pubspec.yaml" },
      -- Disable widget guides for performance
      widget_guides = {
        enabled = false,
      },
      -- Closing tags (lightweight, keep enabled)
      closing_tags = {
        highlight = "Comment",
        prefix = "// ",
        priority = 10,
        enabled = true,
      },
      -- Dev log settings
      dev_log = {
        enabled = true,
        filter = nil,
        notify_errors = true,
        open_cmd = "tabedit",
        focus_on_open = true,
      },
      -- DevTools
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      -- Outline (disabled for performance)
      outline = {
        open_cmd = "30vnew",
        auto_open = false,
      },
      -- LSP settings - optimized for performance
      lsp = {
        color = {
          enabled = true,
          background = false,
          foreground = false,
          virtual_text = true,
        },
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        -- init_options for better suggestions (matches VSCode behavior)
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = true,
          flutterOutline = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            -- Only exclude non-active FVM versions, not the default
            vim.fn.expand "$HOME/fvm/versions",
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
          lineLength = 120,
        },
      },
    }

    -- Disable the built-in dartls to avoid conflicts
    vim.lsp.enable("dartls", false)
  end,
}
