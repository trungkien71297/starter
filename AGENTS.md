# AGENTS.md - NvChad Neovim Configuration

## Build/Lint/Test Commands
- **Format all files**: `stylua .`
- **Check formatting**: `stylua --check .`
- **Format single file**: `stylua path/to/file.lua`
- No tests - this is a personal Neovim configuration

## Code Style Guidelines

### Formatting (.stylua.toml)
- 120 char width, 2-space indent, double quotes preferred, omit call parentheses
- Unix line endings, follow existing patterns

### File Structure
- **Configs**: `lua/configs/` - plugin configuration tables
- **Plugins**: `lua/plugins/` - lazy.nvim specs with lazy loading
- **Core**: `lua/` - mappings.lua, options.lua, autocmds.lua, chadrc.lua

### Conventions
- **Files**: kebab-case (flutter-tool.lua, git-blame.lua)
- **Variables/Functions**: snake_case, descriptive names
- **Keymaps**: Use `vim.keymap.set` with desc tables
- **Plugin specs**: Return tables, use events/keys for lazy loading
- **Imports**: Follow NvChad patterns, require configs in plugin specs
- **Comments**: Minimal, descriptive when needed

### Error Handling
- Use vim.diagnostic.config for LSP diagnostics
- Prefer Lua pcall() for error-prone operations