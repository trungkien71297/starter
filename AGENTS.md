# AGENTS.md - Neovim Configuration Development Guide

## Build/Test Commands
- **Format**: `stylua .` (formats all Lua files according to .stylua.toml)
- **Lint**: No specific linter configured, rely on LSP diagnostics
- **Test**: No test suite present - this is a configuration repository

## Code Style Guidelines
- **Formatting**: Use StyLua with 2-space indentation, 120 column width, Unix line endings
- **Quotes**: Auto-prefer double quotes (`"` over `'`)
- **Function calls**: No parentheses when possible (`require "module"` not `require("module")`)
- **Tables**: Trailing commas allowed, clean formatting
- **Imports**: Use `require "module"` pattern consistently
- **Variables**: Use descriptive names, prefer `local` scope
- **Plugin configs**: Return table from config files, use `opts` pattern for lazy.nvim

## Architecture
- **Structure**: NvChad-based configuration with custom overrides
- **Plugins**: Defined in `lua/plugins/` directory, imported via lazy.nvim
- **Configs**: Plugin configurations in `lua/configs/` directory
- **Mappings**: Custom keymaps in `lua/mappings.lua` extending NvChad defaults
- **Options**: Vim options in `lua/options.lua` extending NvChad defaults

## File Organization
- Keep plugin definitions in separate files under `lua/plugins/`
- Configuration files go in `lua/configs/` and are imported by plugins
- Use consistent naming: plugin file names should match plugin purpose
- Stash unused plugins in `lua/stash/` directory