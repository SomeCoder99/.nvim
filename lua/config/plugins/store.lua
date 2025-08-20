return {
  "alex-popov-tech/store.nvim",
  dependencies = { "OXY2DEV/markview.nvim" },
  lazy = true,
  cmd = "Store",
  opts = {
    width = 0.9,
    height = 0.9,
    show_heading = false,
    plugins_folder = vim.fn.stdpath("config") .. "/lua/config/plugins",
  },
}
