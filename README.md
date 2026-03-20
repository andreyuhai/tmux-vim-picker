---
created: 2026-03-20T12:50:00+0100
last_edited: 2026-03-20T13:00:00+0100
edit_reason: Rewrite for TPM plugin installation
---

# tmux-vim-picker

Open a throwaway nvim session in any repo from a tmux popup. Promote it to a real pane or window when you need it.

## Requirements

- tmux 3.3+ (for `display-popup -e`)
- [TPM](https://github.com/tmux-plugins/tpm)
- nvim
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

Set `TMUX_VIM_PICKER_DIRS` to customize which directories are scanned (colon-separated):

```bash
# In your .bashrc / .zshrc
export TMUX_VIM_PICKER_DIRS="$HOME/work:$HOME/projects"
```

Defaults to `~/work` if not set.
