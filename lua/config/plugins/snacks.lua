local function picker(name)
  return function()
    require("snacks").picker[name]()
  end
end

return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
  },
  keys = {
    -- picker keymaps
    { "<leader>fp", picker("pickers") },
    { "<leader>ff", picker("files") },
    { "<leader>fb", picker("buffers") },
    { "<leader>fg", picker("grep") },
    { "<leader>fn", picker("notifications") },
    { "<leader>fr", picker("recent") },
    { "<leader>f\"", picker("registers") },
    { "<leader>fa", picker("autocmds") },
    { "<leader>fc", picker("commands") },
    { "<leader>fC", picker("colorschemes") },
    { "<leader>fD", picker("diagnostics") },
    { "<leader>fh", picker("help") },
    { "<leader>fH", picker("highlights") },
    { "<leader>fj", picker("jumps") },
    { "<leader>fk", picker("keymaps") },
    { "<leader>fl", picker("loclist") },
    { "<leader>fm", picker("marks") },
    { "<leader>fM", picker("man") },
    { "<leader>fu", picker("undo") },
    { "<leader>ft", picker("todo_comments") },

    -- LSP keymaps
    { "gd", picker("lsp_definitions") },
    { "gD", picker("lsp_declarations") },
    { "gr", picker("lsp_references"), nowait = true },
    { "gI", picker("lsp_implementations") },
    { "gt", picker("lsp_type_definitions") },
    { "<leader>fs", picker("lsp_symbols") },
    { "<leader>fS", picker("lsp_workspace_symbols") },
  },
}
