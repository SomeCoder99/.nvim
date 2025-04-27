-- vim.keymap.set("n", "<leader>e", function ()
--   if vim.bo.ft == "netrw" then
--     vim.cmd("bdelete")
--   else
--     vim.cmd("Explore")
--   end
-- end)

vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  vim.cmd.nohlsearch()
  vim.snippet.stop()
  return "<esc>"
end)
