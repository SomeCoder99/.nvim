return {
  "folke/flash.nvim",
  lazy = true,
  event = "VeryLazy",
  ---@module "flash"
  ---@type Flash.Config
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end },
    { "r", mode = "o", function() require("flash").remote() end },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end },
  },
}
