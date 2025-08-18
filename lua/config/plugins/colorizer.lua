return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    default = { names = false },
  },
  config = function(_, opts)
    require("colorizer").setup(opts.filetypes or {}, opts.default)
  end
}
