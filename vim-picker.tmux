#!/usr/bin/env bash

# tmux-vim-picker — TPM plugin entry point

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"

# Symlink scripts into ~/.local/bin
mkdir -p "$BIN_DIR"
ln -sf "$CURRENT_DIR/bin/tmux-vim-picker" "$BIN_DIR/tmux-vim-picker"
ln -sf "$CURRENT_DIR/bin/tmux-vim-promote" "$BIN_DIR/tmux-vim-promote"

# Register keybinding
tmux bind-key v run-shell "tmux display-popup -w 60% -h 50% -T 'Scratch Vim' -e 'TMUX_PARENT=#{window_id}' -E 'tmux-vim-picker'"
