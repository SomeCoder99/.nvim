return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  ---@module "nvim-surround"
  ---@type user_options
  opts = {
    keymaps = {
      normal = "gs",
      normal_cur = "gss",
      normal_line = "gS",
      normal_cur_line = "gsS",
      visual = "gs",
      visual_line = "gS",
      delete = "dgs",
      change = "cgs",
      change_line = "cgS",
    },
  },
  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end,
}
