return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {},
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")

      configs.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "rust", "toml" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
