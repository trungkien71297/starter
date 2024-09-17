# AGENTS.md - Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua files**: `stylua .` (configured in .stylua.toml)
- **Check formatting**: `stylua --check .`
- **No specific test commands** - this is a Neovim configuration, not a testable codebase

## Code Style Guidelines

### Lua Formatting (.stylua.toml)
- **Column width**: 120 characters
- **Indentation**: 2 spaces
- **Quote style**: Auto-prefer double quotes
- **Call parentheses**: None (omit when possible)

### File Structure
- **Plugin configs**: `lua/configs/` - configuration files for plugins
- **Plugin definitions**: `lua/plugins/` - lazy.nvim plugin specifications
- **Core files**: `lua/` root - mappings.lua, options.lua, autocmds.lua, chadrc.lua

### Naming Conventions
- **Files**: lowercase with hyphens (e.g., `flutter-tool.lua`, `git-blame.lua`)
- **Variables**: snake_case for Lua, follow existing patterns
- **Functions**: snake_case, descriptive names

### Plugin Configuration Pattern
- Return table from config files in `lua/configs/`
- Use lazy loading with appropriate events/keys in plugin specs
- Follow NvChad conventions for plugin organization