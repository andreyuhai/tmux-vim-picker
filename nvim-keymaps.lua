-- tmux-vim-picker: Promote popup nvim to a real tmux window
vim.keymap.set("n", "<leader>P", function()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:p")
  vim.fn.system({ "tmux-vim-promote", "window", cwd, file })
  vim.defer_fn(function() vim.cmd("qa!") end, 100)
end, { desc = "Promote to tmux window" })

-- tmux-vim-picker: Promote popup nvim to a split pane
vim.keymap.set("n", "<leader>p", function()
  local cwd = vim.fn.getcwd()
  local file = vim.fn.expand("%:p")
  vim.fn.system({ "tmux-vim-promote", "split", cwd, file })
  vim.defer_fn(function() vim.cmd("qa!") end, 100)
end, { desc = "Promote to tmux split" })
