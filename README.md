# tmux-vim-picker

Open a throwaway nvim session in any repo from a tmux popup. Promote it to a real pane or window when you need it.

## Why

If you work across many repos with a tmux session per project, you've probably been there: you need to quickly check a file in another repo — maybe to verify an interface, check how something is implemented, or just fact-check yourself. So you switch sessions, open the file, close it, switch back. Or worse, you open a new split, forget about it, and end up with a graveyard of stale panes.

This plugin gives you a fast, disposable way to peek at any repo without leaving your current session. A popup appears, you fuzzy-find a repo, nvim opens right there inside the popup. When you're done, `:q` and it's gone — no extra windows, no panes left behind, no session switching.

And if you realize mid-read that you actually need that file open longer, you can promote it to a real tmux window or split pane without starting over.

## Requirements

- tmux 3.3+ (for `display-popup -e`)
- [TPM](https://github.com/tmux-plugins/tpm)
- nvim (or any `$EDITOR` — see [Configuration](#configuration))
- fzf
- `~/.local/bin` in your `PATH`

## Install

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'andreyuhai/tmux-vim-picker'
```

Hit `prefix + I` to install.

### nvim keymaps (for promote)

Copy the contents of `nvim-keymaps.lua` into your nvim keymaps config:

```lua
-- Promote popup nvim to a real tmux window
vim.keymap.set("n", "<leader>P", function()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:p")
  vim.fn.system({ "tmux-vim-promote", "window", cwd, file })
  vim.defer_fn(function() vim.cmd("qa!") end, 100)
end, { desc = "Promote to tmux window" })

-- Promote popup nvim to a split pane
vim.keymap.set("n", "<leader>p", function()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:p")
  vim.fn.system({ "tmux-vim-promote", "split", cwd, file })
  vim.defer_fn(function() vim.cmd("qa!") end, 100)
end, { desc = "Promote to tmux split" })
```

## Usage

1. **`prefix + v`** — popup with fzf listing all repos
2. Pick a repo — nvim opens inside the popup
3. `:q` when done — popup disappears, no trace
4. **`<leader>P`** — promote to a new tmux window (tab)
5. **`<leader>p`** — promote to a split pane next to where you were

## Configuration

### Directories to scan

Set `TMUX_VIM_PICKER_DIRS` to customize which directories are scanned (colon-separated):

```bash
# In your .bashrc / .zshrc
export TMUX_VIM_PICKER_DIRS="$HOME/work:$HOME/projects"
```

Defaults to `~/work` if not set.

### Editor

The picker launches `$EDITOR` (falling back to `nvim` if unset):

```bash
export EDITOR=nvim   # or vim, hx, emacs, ...
```

Note: the promote keymaps in `nvim-keymaps.lua` are nvim-specific. If you use a different editor, adapt the same pattern — call `tmux-vim-promote <split|window> <cwd> [file]` and then quit — using your editor's scripting API.
