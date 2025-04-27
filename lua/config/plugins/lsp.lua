local border = "single"

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      servers = {
        lua_ls = {},
        rust_analyzer = {},
        ccls = {},
      },
    },
    config = function(_, opts)
      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
        virtual_text = true,
      }

      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,

    keys = {
      { "]d", function() vim.diagnostic.jump { count = 1, float = { border = border } } end },
      { "[d", function() vim.diagnostic.jump { count = -1, float = { border = border } } end },
      { "K", function() vim.lsp.buf.hover { border = border, max_width = 80 } end },
      { "<leader>cr", function() vim.lsp.buf.rename() end },
      { "<leader>ca", function() vim.lsp.buf.code_action() end },
    },
  },
}
