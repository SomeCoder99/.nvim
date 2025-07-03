-- Clear search highlight on escape
vim.keymap.set("n", "<esc>", function()
  vim.snippet.stop()
  vim.cmd.nohlsearch()
end)
