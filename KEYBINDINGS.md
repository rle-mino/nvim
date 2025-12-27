# Keybindings Reference

This document provides a comprehensive list of all keybindings in this Neovim configuration, organized by category.

**Leader Key**: `Space`

## Table of Contents

- [General Editor](#general-editor)
- [Navigation & Scrolling](#navigation--scrolling)
- [Buffer Management](#buffer-management)
- [File Explorer (Neo-tree)](#file-explorer-neo-tree)
- [Fuzzy Finding (Telescope)](#fuzzy-finding-telescope)
- [LSP & Code Navigation](#lsp--code-navigation)
- [Code Completion](#code-completion)
- [Code Commenting](#code-commenting)
- [Git (LazyGit)](#git-lazygit)
- [AI Assistant (OpenCode)](#ai-assistant-opencode)
- [Auto Pairs](#auto-pairs)
- [Surround](#surround)
- [Visual Mode](#visual-mode)
- [Treesitter Selection](#treesitter-selection)

---

## General Editor

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + w` | Normal | `:w<CR>` | Save current file |
| `Space + q` | Normal | `:q<CR>` | Quit current window |
| `Space + nh` | Normal | `:nohlsearch<CR>` | Clear search highlights |
| `Space` | Normal | Wait 300ms | Show which-key menu with all available commands |

---

## Navigation & Scrolling

Smooth scrolling with animated transitions for a more polished editing experience.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Ctrl + u` | Normal | Scroll Up | Scroll half-page up with smooth animation |
| `Ctrl + d` | Normal | Scroll Down | Scroll half-page down with smooth animation |
| `Ctrl + b` | Normal | Scroll Back | Scroll full-page up with smooth animation |
| `Ctrl + f` | Normal | Scroll Forward | Scroll full-page down with smooth animation |
| `Ctrl + y` | Normal | Line Up | Scroll one line up with smooth animation |
| `Ctrl + e` | Normal | Line Down | Scroll one line down with smooth animation |
| `zt` | Normal | Top | Move current line to top of screen (animated) |
| `zz` | Normal | Center | Center current line on screen (animated) |
| `zb` | Normal | Bottom | Move current line to bottom of screen (animated) |

**Features:**
- All scrolling commands use smooth sine-easing animations
- Cursor is hidden during scroll for cleaner visual experience
- Scrolling stops at end of file (no empty lines beyond buffer)

---

## Buffer Management

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Shift + h` | Normal | `:bprevious<CR>` | Go to previous buffer |
| `Shift + l` | Normal | `:bnext<CR>` | Go to next buffer |
| `Space + x` | Normal | Close buffer | Close current buffer and switch to previous |
| `Space + fb` | Normal | Telescope | Find and switch to open buffer |

**Buffer Line:**
- Use `Shift + h/l` to navigate between buffers
- Use `Space + x` to close current buffer
- LSP diagnostics shown inline on buffer tabs

---

## File Explorer (Neo-tree)

### Opening and Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + e` | Normal | Toggle Focus | Toggle focus between neo-tree and editor |

### Inside Neo-tree

| Key | Action | Description |
|-----|--------|-------------|
| `Enter` / `l` | Open | Open file or expand directory |
| `h` | Close | Collapse directory |
| `Space` | Toggle | Toggle node expansion |
| `P` | Preview | Toggle floating preview |
| `q` | Close | Close neo-tree window |
| `R` | Refresh | Refresh file tree |
| `?` | Help | Show all available commands |

### File Operations

| Key | Action | Description |
|-----|--------|-------------|
| `a` | Add File | Create new file (relative path) |
| `A` | Add Directory | Create new directory |
| `d` | Delete | Delete file or directory |
| `r` | Rename | Rename file or directory |
| `c` | Copy | Copy file (will prompt for destination) |
| `m` | Move | Move file (will prompt for destination) |
| `y` | Copy to Clipboard | Copy file path to clipboard |
| `x` | Cut | Cut file to clipboard |
| `p` | Paste | Paste from clipboard |

### Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `S` | Split | Open file in horizontal split |
| `s` | VSplit | Open file in vertical split |
| `t` | Tab | Open file in new tab |
| `w` | Window Picker | Choose window to open file in |

### Sorting and Filtering

| Key | Action | Description |
|-----|--------|-------------|
| `H` | Toggle Hidden | Show/hide hidden files |
| `.` | Set Root | Set current directory as root |
| `Backspace` | Up | Navigate to parent directory |
| `i` | Details | Show file details |
| `oc` | Order by Created | Sort by creation date |
| `od` | Order by Diagnostics | Sort by LSP diagnostics |
| `om` | Order by Modified | Sort by modification date |
| `on` | Order by Name | Sort alphabetically |
| `os` | Order by Size | Sort by file size |
| `ot` | Order by Type | Sort by file type |

---

## Fuzzy Finding (Telescope)

### File Finding

| Key | Action | Description |
|-----|--------|-------------|
| `Space + ff` | Find Files | Search files in project (includes hidden) |
| `Space + fg` | Live Grep | Search text across all files |
| `Space + fr` | Recent Files | Browse recently opened files |
| `Space + fe` | Find .env | Search specifically for .env files |
| `Space + fc` | Find Word | Search for word under cursor |

### Code Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `Space + fd` | Diagnostics | List all LSP diagnostics |
| `Space + fs` | Document Symbols | Browse symbols in current file |
| `Space + fS` | Workspace Symbols | Browse symbols in workspace |

### Other

| Key | Action | Description |
|-----|--------|-------------|
| `Space + fb` | Buffers | List and switch between open buffers |
| `Space + fh` | Help Tags | Search Neovim help documentation |

### Inside Telescope Prompt

**Insert Mode:**

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl + j/k` | Navigate | Move selection up/down |
| `Ctrl + n/p` | History | Cycle through search history |
| `Enter` | Select | Open selected file |
| `Ctrl + x` | Horizontal Split | Open in horizontal split |
| `Ctrl + v` | Vertical Split | Open in vertical split |
| `Ctrl + t` | Tab | Open in new tab |
| `Ctrl + u/d` | Scroll Preview | Scroll preview window |
| `Ctrl + c` | Close | Close Telescope |
| `Tab` | Toggle Selection | Select/deselect item and move down |
| `Shift + Tab` | Toggle Selection | Select/deselect item and move up |
| `Ctrl + q` | Send to Quickfix | Send results to quickfix list |

**Normal Mode** (press `Esc` to enter):

| Key | Action | Description |
|-----|--------|-------------|
| `j/k` | Navigate | Move selection up/down |
| `gg` | Top | Jump to first result |
| `G` | Bottom | Jump to last result |
| `H/M/L` | Jump | Jump to top/middle/bottom of visible results |
| `dd` (in buffers) | Delete Buffer | Close the selected buffer |

**Live Grep Specific:**

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl + k` | Quote | Quote the prompt for exact matching |
| `Ctrl + i` | Glob Pattern | Add glob pattern for file filtering |

---

## LSP & Code Navigation

### Go To Commands

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gD` | Go to Declaration | Jump to symbol declaration |
| `gi` | Go to Implementation | Jump to symbol implementation |
| `gr` | Go to References | Show all references (grouped by file) |
| `K` | Hover | Show documentation for symbol under cursor |
| `Ctrl + k` | Signature Help | Show function signature help |

### Code Actions

| Key | Action | Description |
|-----|--------|-------------|
| `Space + rn` | Rename | Rename symbol across workspace |
| `Space + ca` | Code Action | Show available code actions |
| `Space + lf` | Format | Format current buffer |

### Diagnostics

| Key | Action | Description |
|-----|--------|-------------|
| `Space + d` | Line Diagnostics | Show diagnostics for current line |
| `[d` | Previous Diagnostic | Jump to previous diagnostic |
| `]d` | Next Diagnostic | Jump to next diagnostic |
| `Space + fd` | All Diagnostics | List all diagnostics in Telescope |

### LSP Management

| Command | Description |
|---------|-------------|
| `:LspInfo` | Show LSP client information |
| `:LspRestart` | Restart LSP servers |
| `:Mason` | Open Mason installer for LSP servers |

---

## Code Completion

Completion menu appears automatically in Insert mode.

### AI Completion (Supermaven)

Supermaven provides inline AI-powered code suggestions.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Tab` | Insert | Accept/Navigate | Accept Supermaven suggestion if available, otherwise navigate cmp menu or jump to next snippet placeholder |
| `Escape` | Insert | Dismiss | Dismiss Supermaven suggestion (stays in insert mode) or exit insert mode if no suggestion |

### Completion Menu (nvim-cmp)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Ctrl + Space` | Insert | Trigger | Manually trigger completion menu |
| `Enter` | Insert | Confirm | Accept selected completion item from menu |
| `Tab` | Insert | Next | Select next item in completion menu (if visible and no Supermaven suggestion) |
| `Shift + Tab` | Insert | Previous | Select previous item or jump to previous snippet placeholder |
| `Ctrl + e` | Insert | Abort | Close completion menu |
| `Ctrl + b` | Insert | Scroll Up | Scroll documentation up |
| `Ctrl + f` | Insert | Scroll Down | Scroll documentation down |

**Completion Sources** (in order of priority):
1. LSP suggestions
2. Snippets (LuaSnip)
3. Lua API (for Neovim config files)
4. Buffer words
5. File paths

**Note**: Supermaven provides inline suggestions separately from the completion menu. The Tab key prioritizes Supermaven suggestions over completion menu navigation.

---

## Code Commenting

Smart commenting with tree-sitter integration for context-aware comments.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + /` | Normal | Toggle Comment | Comment/uncomment current line and move to next line |
| `Space + /` | Visual | Toggle Comment | Comment/uncomment selected lines |

**Features:**
- Automatically uses correct comment syntax based on file type
- Tree-sitter integration for context-aware commenting (respects JSX/TSX syntax)
- In normal mode, cursor moves to next line after commenting for easy multi-line commenting
- Preserves indentation when commenting/uncommenting

---

## Git (LazyGit & GitSigns)

### LazyGit

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + gg` | Normal | Open LazyGit | Open LazyGit in floating window |

#### Inside LazyGit

LazyGit uses its own keybindings. Press `?` inside LazyGit to see all commands.

**Common LazyGit commands:**
- `Space`: Stage/unstage file or hunk
- `c`: Commit
- `P`: Push
- `p`: Pull
- `Enter`: View file changes
- `d`: View diff options
- `l`: View logs
- `b`: View branches
- `q`: Quit LazyGit

### GitSigns (In-Editor Git)

#### Navigation

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]c` | Normal | Next Hunk | Jump to next git change |
| `[c` | Normal | Previous Hunk | Jump to previous git change |

#### Staging & Reset

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + gs` | Normal | Stage Hunk | Stage current hunk |
| `Space + gs` | Visual | Stage Hunk | Stage selected hunk |
| `Space + gr` | Normal | Reset Hunk | Reset current hunk |
| `Space + gr` | Visual | Reset Hunk | Reset selected hunk |
| `Space + gS` | Normal | Stage Buffer | Stage entire file |
| `Space + gu` | Normal | Undo Stage | Undo last stage operation |
| `Space + gR` | Normal | Reset Buffer | Reset entire file to HEAD |

#### Blame & History

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + gb` | Normal | Blame Line | Show full blame for current line |
| `Space + gB` | Normal | Open Commit | Open commit in browser (GitHub/GitLab/etc.) |
| `Space + gtb` | Normal | Toggle Blame | Toggle inline blame display |

**Note:** Inline blame is enabled by default and shows author, date, and commit summary at the end of each line.

#### Diff & Preview

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + gp` | Normal | Preview Hunk | Preview changes in floating window |
| `Space + gd` | Normal | Diff This | Show diff for current file |
| `Space + gD` | Normal | Diff This ~ | Show diff against previous commit |
| `Space + gtd` | Normal | Toggle Deleted | Toggle display of deleted lines |

#### Text Objects

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `ih` | Operator/Visual | Select Hunk | Select current git hunk as text object |

**Examples:**
- `vih` - Visual select current hunk
- `dih` - Delete current hunk
- `yih` - Yank current hunk

---

## AI Assistant (OpenCode)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Space + oo` | Normal/Terminal | Toggle/Focus | Open or toggle focus to OpenCode |
| `Space + ol` | Normal/Visual | Add Lines | Add selected lines to OpenCode context |
| `Space + oa` | Normal/Visual | Execute Action | Execute OpenCode action menu |
| `Space + of` | Normal | Add File | Add current file to OpenCode context |

### Inside OpenCode Terminal

| Key | Action | Description |
|-----|--------|-------------|
| `Space + oo` | Switch Back | Return focus to editor |
| `Ctrl + c` | Interrupt | Stop current OpenCode process |
| Regular terminal commands work |

---

## Auto Pairs

Automatic bracket, quote, and parenthesis pairing with tree-sitter integration.

### Automatic Pairing

The following characters are automatically paired when typed in Insert mode:
- `(` creates `()`
- `[` creates `[]`
- `{` creates `{}`
- `"` creates `""`
- `'` creates `''`

The closing character is automatically added, and your cursor is placed between them.

### Tree-sitter Integration

Auto pairs intelligently handles pairing based on syntax context:
- Won't auto-pair inside strings (unless opening a nested string)
- Respects language-specific syntax rules
- Works seamlessly in Lua, JavaScript, and TypeScript files

### CMP Integration

When accepting a completion with parentheses from nvim-cmp, the closing parenthesis is automatically managed to avoid duplicates.

---

## Surround

Add, change, and delete surrounding characters (brackets, quotes, tags, function calls, etc.).

### Add Surround

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `ys{motion}{char}` | Normal | Add Surround | Surround text with character after motion |
| `yss{char}` | Normal | Add Line Surround | Surround entire line with character |
| `yS{motion}{char}` | Normal | Add Block Surround | Surround and place on new lines |
| `ySS{char}` | Normal | Add Line Block | Surround entire line and place on new lines |
| `S{char}` | Visual | Add Surround | Surround visual selection with character |

**Examples:**
- `ysiw"` - Surround word with double quotes: `word` → `"word"`
- `ysiw)` - Surround word with parentheses: `word` → `(word)`
- `ysiw]` - Surround word with brackets (no space): `word` → `[word]`
- `ysiw[` - Surround word with brackets (with space): `word` → `[ word ]`
- `ysiwt<div>` - Surround word with HTML tag: `word` → `<div>word</div>`
- `yss"` - Surround entire line with quotes
- `ySiw{` - Surround word with braces on new lines:
  ```
  word
  ```
  becomes:
  ```
  {
    word
  }
  ```

### Change Surround

| Key | Action | Description |
|-----|--------|-------------|
| `cs{old}{new}` | Change Surround | Replace surrounding character |
| `cst{new}` | Change Tag | Change surrounding HTML/XML tag |

**Examples:**
- `cs"'` - Change double quotes to single: `"hello"` → `'hello'`
- `cs)]` - Change parentheses to brackets: `(hello)` → `[hello]`
- `cs({` - Change parentheses to braces with space: `(hello)` → `{ hello }`
- `cst<p>` - Change surrounding tag to `<p>`: `<div>hello</div>` → `<p>hello</p>`

### Delete Surround

| Key | Action | Description |
|-----|--------|-------------|
| `ds{char}` | Delete Surround | Remove surrounding character |
| `dst` | Delete Tag | Remove surrounding HTML/XML tag |

**Examples:**
- `ds"` - Remove double quotes: `"hello"` → `hello`
- `ds)` - Remove parentheses: `(hello)` → `hello`
- `ds{` - Remove braces: `{ hello }` → `hello`
- `dst` - Remove HTML tag: `<div>hello</div>` → `hello`

### Supported Characters

| Character | Creates |
|-----------|---------|
| `(` or `)` | Parentheses with/without space: `( text )` or `(text)` |
| `{` or `}` | Braces with/without space: `{ text }` or `{text}` |
| `[` or `]` | Brackets with/without space: `[ text ]` or `[text]` |
| `<` or `>` | Angle brackets: `<text>` |
| `'` | Single quotes: `'text'` |
| `"` | Double quotes: `"text"` |
| `` ` `` | Backticks: `` `text` `` |
| `t` | HTML/XML tag (prompts for tag name) |

### Text Objects

You can use vim motions with surround operations:

- `ysiw"` - Surround inner word
- `ysa"(` - Surround around quotes with parens: `"hello"` → `("hello")`
- `ysap{` - Surround around paragraph with braces
- `ysi)(` - Surround inside parentheses with another set
- `cs"'` - Change surrounding quotes

**Tip:** All surround operations support dot-repeat (`.` key), making it easy to repeat the operation on multiple locations.

---

## Visual Mode

| Key | Action | Description |
|-----|--------|-------------|
| `J` | Move Down | Move selected line(s) down |
| `K` | Move Up | Move selected line(s) up |
| `Space + /` | Toggle Comment | Comment/uncomment selected lines |
| `Space + ol` | OpenCode | Add selection to OpenCode |
| `Space + oa` | OpenCode Action | Execute OpenCode action on selection |

After moving lines, selection is preserved and code is auto-indented.

---

## Treesitter Selection

Treesitter provides smart, syntax-aware selection expansion.

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `Ctrl + Space` | Normal | Init Selection | Start incremental selection |
| `Ctrl + Space` | Visual | Expand | Expand selection to next syntax node |
| `Backspace` | Visual | Shrink | Shrink selection to previous syntax node |

**Example workflow:**
1. Place cursor inside a function
2. Press `Ctrl + Space` to select the word
3. Press `Ctrl + Space` again to select the parameter
4. Press `Ctrl + Space` again to select the entire function
5. Press `Backspace` to shrink back

---

## Tips and Tricks

### Quick File Navigation

1. **Recent files**: `Space + fr` - Shows your most recently edited files
2. **Buffer switching**: `Shift + h/l` - Quick navigation between open buffers
3. **Jump to definition and back**: `gd` then `Ctrl + o` to jump back

### Search Workflows

1. **Project-wide search**: `Space + fg` - Live grep across all files
2. **Search current word**: Place cursor on word, press `Space + fc`
3. **Filter by file type**: In live grep, press `Ctrl + i` and add pattern like `*.ts`

### LSP Features

1. **Rename refactoring**: `Space + rn` - Safely rename across entire project
2. **Auto-fix**: `Space + ca` - Show quick fixes and refactoring options
3. **Format on save**: ESLint auto-fixes JavaScript/TypeScript on save

### Multi-file Editing

1. **Quickfix workflow**:
   - Search with `Space + fg`
   - Select multiple items with `Tab`
   - Send to quickfix with `Ctrl + q`
   - Navigate with `:cnext` and `:cprev`

### Git Workflow

1. **Stage and commit**:
   - `Space + gg` to open LazyGit
   - Navigate to changed files
   - Press `Space` to stage
   - Press `c` to commit
   - Write message and confirm
   - Press `P` to push

### OpenCode AI Workflow

1. **Get help with current file**:
   - `Space + of` to add file to context
   - `Space + oo` to focus OpenCode
   - Type your question
   - `Space + oo` to return to editor

2. **Refactor selection**:
   - Select code in visual mode
   - `Space + ol` to add to OpenCode
   - Request refactoring
   - Review and apply changes

---

## Customizing Keybindings

To add or modify keybindings, edit the appropriate configuration file:

- **Global keybindings**: `lua/config/keymaps.lua`
- **Plugin-specific**: Individual plugin files in `lua/plugins/`
- **LSP keybindings**: `lua/plugins/lsp.lua` (in the `on_attach` function)

**Example custom keybinding:**

```lua
-- Add to lua/config/keymaps.lua
vim.keymap.set("n", "<leader>h", ":echo 'Hello!'<CR>", { desc = "Say hello" })
```

---

## Getting Help

- **Which-key menu**: Press `Space` and wait - shows all available leader commands
- **Inside Telescope**: Press `Ctrl + ?` or `?` (in normal mode)
- **Inside Neo-tree**: Press `?`
- **Inside LazyGit**: Press `?`
- **Vim help**: `Space + fh` then search for topics
- **LSP info**: `:LspInfo` to see active language servers
- **Check mappings**: `:map` to see all mappings, `:map <leader>` to see leader mappings
