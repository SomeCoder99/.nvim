local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }

return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
      win_options = {
        number = false,
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        win_options = {
          winhighlight = "EndOfBuffer:FloatEndOfBuffer",
        },
      },
      confirmation = {
        border = border,
      },
      progress = {
        border = "single",
      },
      ssh = {
        border = "single",
      },
      keymaps_help = {
        border = border,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,

    keys = {
      {
        "<leader>e",
        function()
          require("oil").toggle_float()
        end,
        desc = "File Explorer (oil.nvim)",
      },
    },
  },
}
