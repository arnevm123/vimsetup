# AGENTS.md — Neovim Configuration

Personal Neovim configuration written entirely in Lua, managed by lazy.nvim.

## Project Structure

```
init.lua                    # Entry point — requires 7 base modules in order
lua/
  base/                     # Core config (options, keymaps, autocommands, statusline, utils)
  plugins/                  # lazy.nvim plugin specs (auto-discovered by directory)
    lsp/                    #   LSP sub-module (init, servers, completion, formatting, installation)
    snacks/                 #   Snacks.nvim picker config + custom multi-grep
    snip/                   #   LuaSnip snippet helpers (Go treesitter-aware)
ftplugin/                   # 28 filetype-specific configs (go, lua, rust, python, etc.)
lsp/                        # Per-LSP-server config files (vim.lsp.config style)
queries/go/injections.scm   # Custom treesitter injection queries
snippets/                   # VSCode-format JSON snippet files
spell/                      # Spell checking dictionary
```

## Build / Lint / Test Commands

There is no build system for this config itself. The tools below are what Neovim
uses internally for linting and formatting Lua files in this repo:

### Formatting (Lua)

```sh
# Format a single file
stylua <file.lua>

# Format all Lua files
stylua .
```

Config: `.stylua.toml` — single setting: `collapse_simple_statement = "Always"`.
StyLua defaults apply: tabs for indentation, 120-char line width.

### Linting (Lua)

```sh
# Lint a single file
selene <file.lua>

# Lint all Lua files
selene .
```

Config: `selene.toml` — `std="lua51+vim"`, allows `mixed_table`, declares `Snacks` as global.
Standard library definition: `vim.toml` (`[vim] any = true`).

### Testing

No automated test suite exists for this config. Changes should be validated by
opening Neovim and verifying the affected functionality works.

For projects **edited within** this Neovim (not this config itself):
- `:Make` runs `b:dispatch` (e.g. `go test ./...` for Go files)
- `compile-mode.nvim` binds `<leader>bb` (build), `<leader>bt` (test), `<leader>bl` (lint), `<leader>br` (run) — all invoke `make <target>`
- `neotest` provides per-test/file/suite runners for Go, Rust, Python, Plenary

## Code Style Guidelines

### Language and Runtime

- **Lua 5.1** targeting Neovim's built-in LuaJIT runtime.
- Use `vim.*` APIs (vim.api, vim.fn, vim.cmd, vim.keymap, vim.lsp, vim.diagnostic, etc.).

### Indentation and Formatting

- **Tabs, not spaces.** `expandtab = false`, `tabstop = 4`, `shiftwidth = 4`.
- Line width: **120 characters** (StyLua default).
- StyLua `collapse_simple_statement = "Always"` — single-statement blocks go on one line:
  ```lua
  if cond then return end
  if not x then return nil end
  for _, v in ipairs(t) do count = count + 1 end
  ```
- Always run `stylua` before committing Lua changes.

### Module Patterns

- **Utility/library modules** use the `local M = {} ... return M` pattern:
  ```lua
  local M = {}
  function M.my_function() ... end
  return M
  ```
- **Plugin spec files** return a table (or table of tables) of lazy.nvim specs directly:
  ```lua
  return {
      { "author/plugin-name", opts = { ... } },
  }
  ```
- **LSP server configs** (`lsp/*.lua`) return a `vim.lsp.Config` table.
- **ftplugin files** set buffer-local options directly (no module wrapper).

### Imports and Requires

- Cross-module: `require("base.utils")`, `require("plugins.lsp.servers")`.
- External plugins: `require("plugin-name")` — often inside callbacks for lazy-loading.
- Alias at file top when used multiple times:
  ```lua
  local utils = require("base.utils")
  local keymap = vim.keymap.set
  ```
- Use `pcall(require, "module")` for optional dependencies.
- Never use `module()` or global assignments for modules (except the `Fd` function in options.lua).

### Naming Conventions

- **Files**: lowercase, hyphen-separated (`lang-specific.lua`, `lsp-adjecent.lua`).
- **Directories**: lowercase, no hyphens (`base/`, `plugins/`, `snip/`).
- **Functions on M (public)**: snake_case (`M.git_cwd`, `M.grep_string`, `M.fzf_fd`).
  Some legacy toggle/action functions use PascalCase (`M.CToggle`, `M.VirtualTextToggle`); follow snake_case for new code.
- **Local/private functions**: snake_case (`get_git_branch`, `can_lsp_rename`).
- **Variables**: snake_case (`file_pattern`, `search_string`, `lazypath`).
- **Keymap option tables**: descriptive local names (`opts`, `nosilent`, `expr`).

### Keymap Conventions

- Leader key: `<Space>`.
- Define option tables at file top: `local opts = { noremap = true, silent = true }`.
- Alias: `local keymap = vim.keymap.set`.
- Leader prefix groupings: `g*` (git), `f*` (find), `l*` (LSP), `t*` (test), `d*` (debug), `b*` (build), `yo*` (toggles).
- Plugin keymaps go in the lazy.nvim `keys` table for automatic lazy-loading.

### Error Handling

- Use `pcall` for optional features and graceful degradation.
- Guard with early returns: `if not x then return end`.
- User-facing messages: `vim.notify(msg, level)` (not `print()`).
- Suppress diagnostics selectively: `---@diagnostic disable-next-line: reason`.

### Type Annotations

- Use LuaLS annotations where helpful: `---@param`, `---@return`, `---@class`, `---@type`.
- Not required exhaustively — use them for utility functions, complex opts tables, and public APIs.

### Plugin Management

- Package manager: **lazy.nvim** (stable branch, auto-installed).
- All plugins default to `lazy = true`. Use `event`, `cmd`, `keys`, or `ft` for lazy-loading triggers.
- Plugin specs are auto-discovered from `lua/plugins/` — one file per plugin group.
- LSP servers / formatters / linters installed via **Mason** (`mason.nvim` + `mason-lspconfig` + `mason-tool-installer`).
- Two LSP servers are manually installed (not via Mason): `gopls`, `rust_analyzer`.

### Things to Avoid

- Do not use `vim.cmd` for things that have Lua API equivalents.
- Do not add global variables (the `Fd` function in options.lua is a rare exception for `vim.opt.findfunc`).
- Do not use spaces for indentation — this project uses tabs.
- Do not create new plugin spec files without following the existing `return { { ... } }` pattern.
- Do not hardcode paths — use `vim.fn.stdpath()`, `vim.fn.getcwd()`, `vim.loop.cwd()`.
- Do not add emoji to code or comments.

### External Tool Config Paths (referenced by this config)

- cspell: `~/.config/linters/cspell.json`, `~/.config/linters/allowed-words`
- commitlint: `~/.config/linters/commitlint.config.os`
- DB connections: `.db_connections/` (gitignored)
