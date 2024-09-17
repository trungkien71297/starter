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
        enabled = false, -- Enable if you use nvim-dap
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
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
          enabled = false, -- Disable for performance
          background = false,
          foreground = false,
          virtual_text = false,
        },
        capabilities = require("nvchad.configs.lspconfig").capabilities,
        -- Performance-critical init_options
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = false,
          closingLabels = true,
          outline = false,
          flutterOutline = false,
        },
        settings = {
          showTodos = false,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand "$HOME/.pub-cache",
            vim.fn.expand "$HOME/fvm/versions",
            vim.fn.expand "$HOME/fvm/default",
            vim.fn.expand "$HOME/.dartServer",
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true, -- Enable for st/stateful snippets
          updateImportsOnRename = true,
        },
      },
    }

    -- Disable the built-in dartls to avoid conflicts
    vim.lsp.enable("dartls", false)
  end,
}
