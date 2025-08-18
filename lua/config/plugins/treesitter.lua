return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "html",
        "rust",
        "toml",
      },
      highlight = {
        enable = true,
      },
      folds = { enable = true },
      indent = {
        enable = true,
        disable = { "teal" },
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
}
