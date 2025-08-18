return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local bufferline = require "bufferline"
      bufferline.setup {
        options = {
          themable = true,
          indicator = { style = "none" },
          modified_icon = " ",
          left_trunc_marker = "<-",
          right_trunc_marker = "->",
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "slant",
          always_show_bufferline = false,
        },
      }
    end,
    keys = {
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle Previous Buffer" },
      { "<space>b", "", desc = "Buffers" },
      { "<space>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
      { "<space>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
      { "<space>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close Buffer" },
      { "<space>b[", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer To The Previous Buffer" },
      { "<space>b]", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer To The Next Buffer" },
    },
  },
}
