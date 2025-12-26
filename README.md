# Neovim Configuration

A modern, feature-rich Neovim configuration focused on web development with TypeScript/JavaScript, built from scratch with Lua and lazy.nvim.

## Philosophy

This configuration is **opinionated and built from scratch** - no presets, no distributions. It's designed to solve my specific problems, my way. Every plugin and keybinding is intentionally chosen for my workflow. If this doesn't match your needs or preferences, feel free to fork it and make it your own, or use a different configuration entirely.

## Features

### Core Components

- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) - Fast and modern plugin manager
- **Colorscheme**: [Dracula](https://github.com/Mofiqul/dracula.nvim) - Custom-configured dark theme
- **Leader Key**: `Space` - All custom keybindings use Space as the leader key

### Language Support & LSP

Full Language Server Protocol (LSP) integration with intelligent code completion, diagnostics, and formatting:

- **LSP Servers** (auto-installed via Mason):
  - TypeScript/JavaScript: `typescript-tools.nvim` with enhanced features
  - ESLint: Auto-fix on save
  - Biome: Modern linter/formatter
  - Lua: `lua_ls` with Neovim-specific configuration
  - JSON: `jsonls` with schema validation
  - HTML/CSS: `html`, `cssls`

- **AI-Powered Completion** ([supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim)):
  - Inline AI code suggestions
  - Context-aware completions
  - Smart Tab key integration

- **Autocompletion** ([nvim-cmp](https://github.com/hrsh7th/nvim-cmp)):
  - LSP-powered suggestions
  - Snippet support via LuaSnip
  - Buffer and path completion
  - Visual completion menu with icons

- **Syntax Highlighting** ([nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)):
  - Advanced syntax highlighting
  - Smart code folding
  - Incremental selection
  - Support for 15+ languages

### File Navigation & Search

- **File Explorer** ([neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)):
  - Opens automatically on startup
  - Git status integration
  - File operations (create, delete, rename, copy, move)
  - Smart toggling and focus management

- **Fuzzy Finder** ([telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)):
  - Fast file finding with `ripgrep`
  - Live grep with advanced search patterns
  - Buffer, symbol, and diagnostic searching
  - Recent files and help tags
  - Hidden files included by default

### Git Integration

- **LazyGit** ([lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)):
  - Full-featured Git UI inside Neovim
  - Floating window interface
  - Stage, commit, push, pull, and more
  - Visual diff and merge conflict resolution
  - Syntax-highlighted diffs with [delta](https://github.com/dandavison/delta)
  - Dracula-themed UI for consistency with Neovim

### AI Assistants

- **OpenCode** ([opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)):
  - AI-powered coding assistant
  - Context-aware code suggestions
  - File and line selection support
  - Integrated terminal interface

- **Supermaven** ([supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim)):
  - Real-time AI code completions
  - Inline suggestion display
  - Seamless integration with completion menu

### User Interface

- **Status Line** ([lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)):
  - Git branch and diff information
  - LSP diagnostics counts
  - File encoding and format
  - Current mode and location

- **Buffer Line** ([bufferline.nvim](https://github.com/akinsho/bufferline.nvim)):
  - Visual buffer tabs
  - Git project name display
  - LSP diagnostic indicators
  - Easy buffer navigation

- **Key Helper** ([which-key.nvim](https://github.com/folke/which-key.nvim)):
  - Interactive keymap guide
  - Shows available keybindings as you type
  - Grouped commands by category

### Editor Features

- **Smart Line Numbers**:
  - Relative numbers in normal mode (for easy motion commands)
  - Absolute numbers in insert mode

- **Auto Pairs** ([nvim-autopairs](https://github.com/windwp/nvim-autopairs)):
  - Automatic bracket, quote, and parenthesis pairing
  - Tree-sitter integration for intelligent pairing
  - Integrated with nvim-cmp for completion

- **Indent Guides** ([indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)):
  - Rainbow indent colors with subtle, discrete hues
  - Visual scope indicators
  - Adapts to colorscheme changes

- **Persistent Undo**:
  - Unlimited undo history saved to disk
  - No swap files

- **Clipboard Integration**:
  - System clipboard sync
  - Easy copy/paste between Neovim and other apps

- **Auto-commands**:
  - Highlight yanked text
  - Remove trailing whitespace on save
  - Line number toggling based on mode

## Requirements

- Neovim >= 0.9.0
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Required for Telescope file searching
- [lazygit](https://github.com/jesseduffield/lazygit) - Required for Git integration
- [git-delta](https://github.com/dandavison/delta) - Required for syntax-highlighted diffs in LazyGit
- A [Nerd Font](https://www.nerdfonts.com/) - Required for icon support
- Node.js - Required for LSP servers

## Installation

1. Backup your existing Neovim configuration (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this configuration:
   ```bash
   git clone https://github.com/rle-mino/rle.nvim ~/.config/nvim
   ```

3. Launch Neovim:
   ```bash
   nvim
   ```

4. The plugin manager will automatically:
   - Install all plugins
   - Download LSP servers
   - Set up syntax parsers

5. Install required dependencies:
   ```bash
   # Required for Telescope file searching
   brew install ripgrep

   # Required for Git integration
   brew install lazygit

   # Required for syntax-highlighted diffs in LazyGit
   brew install git-delta
   ```

6. Restart Neovim to complete the setup

## Quick Start Guide

### Opening Neovim

```bash
# Open current directory
nvim .

# Open a specific file
nvim file.ts

# Open from last session
nvim
```

### First Steps

1. **Explore the file tree**: Press `Space + e` to toggle focus to neo-tree
2. **Find files**: Press `Space + f + f` to search for files
3. **Search in files**: Press `Space + f + g` to live grep
4. **Open Git UI**: Press `Space + g + g` to launch LazyGit
5. **Get help**: Press `Space` and wait - which-key will show available commands

### Essential Workflows

**Editing a file:**
1. Use `Space + f + f` to find and open a file
2. Edit the file
3. Press `Space + w` to save
4. Use `Shift + h/l` to switch between buffers

**Code navigation:**
1. Place cursor on a symbol
2. Press `gd` to go to definition
3. Press `gr` to see all references
4. Press `K` to see documentation

**Git workflow:**
1. Press `Space + g + g` to open LazyGit
2. Stage changes, write commit message
3. Push to remote
4. Press `q` to close LazyGit

## File Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin version lock file
├── lazygit_config.yml         # LazyGit configuration with delta integration
└── lua/
    ├── config/
    │   ├── autocmds.lua       # Auto-commands
    │   ├── keymaps.lua        # Global keybindings
    │   ├── lazy.lua           # Plugin manager setup
    │   └── options.lua        # Editor options
    └── plugins/
        ├── autopairs.lua         # Auto bracket/quote pairing
        ├── buffer-line.lua       # Buffer tabs
        ├── colorscheme.lua       # Theme configuration
        ├── indent-blankline.lua  # Indent guides
        ├── lazygit.lua           # Git integration
        ├── lsp.lua               # Language servers
        ├── lua-line.lua          # Status line
        ├── neo-tree.lua          # File explorer
        ├── opencode.lua          # AI assistant
        ├── supermaven.lua        # AI completion
        ├── snacks.lua            # Utility functions
        ├── telescope.lua         # Fuzzy finder
        ├── treesitter.lua        # Syntax highlighting
        └── whichkey.lua          # Keymap helper
```

## Customization

### Changing the Theme

Edit `lua/plugins/colorscheme.lua` to customize colors or switch themes.

### Adding New LSP Servers

Edit `lua/plugins/lsp.lua` and add servers to the `ensure_installed` table:

```lua
ensure_installed = {
  "eslint",
  "biome",
  "your_new_server",
},
```

### Custom Keybindings

Add your keybindings to `lua/config/keymaps.lua`:

```lua
keymap("n", "<your-key>", "<your-command>", { desc = "Description" })
```

### Plugin Management

- **Install a new plugin**: Add it to the appropriate file in `lua/plugins/` or create a new file
- **Update plugins**: Run `:Lazy update`
- **Remove a plugin**: Delete its configuration file and run `:Lazy clean`

## Keybindings Reference

See [KEYBINDINGS.md](./KEYBINDINGS.md) for a comprehensive list of all keybindings organized by category.

## Troubleshooting

### LSP not working

1. Check LSP server status: `:LspInfo`
2. Install missing servers: `:Mason`
3. Restart LSP: `:LspRestart`

### Plugins not loading

1. Update plugins: `:Lazy sync`
2. Check for errors: `:Lazy`
3. Clear cache: `rm -rf ~/.local/share/nvim`

### Slow startup

1. Check startup time: `nvim --startuptime startup.log`
2. Review lazy-loading configuration
3. Disable unused plugins

## Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Learn Lua in Y minutes](https://learnxinyminutes.com/docs/lua/)
- [Neovim from Scratch](https://github.com/LunarVim/Neovim-from-scratch)

## License

This configuration is provided as-is for personal use.
