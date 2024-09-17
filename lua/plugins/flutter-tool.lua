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
        enabled = true, -- Enable if you use nvim-dap
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(_)
          require("dap").configurations.dart = {}
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
