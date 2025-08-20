return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local c = require "config.palette"
      local theme = {
        normal = {
          a = { bg = c.b.da(30).sa(-30).hex, fg = c.bg.hex, gui = "bold" },
          b = { bg = c.bg.li(6).hex, fg = c.b.sa(-10).hex },
          c = { bg = c.bg.li(2).hex, fg = c.fg.hex },
        },
        insert = {
          a = { bg = c.g.da(30).sa(-50).hex, fg = c.bg.hex, gui = "bold" },
          b = { bg = c.bg.li(6).hex, fg = c.g.sa(-10).hex },
          c = { bg = c.bg.li(2).hex, fg = c.fg.hex },
        },
        visual = {
          a = { bg = c.p.da(30).sa(-50).hex, fg = c.bg.hex, gui = "bold" },
          b = { bg = c.bg.li(6).hex, fg = c.p.sa(-10).hex },
          c = { bg = c.bg.li(2).hex, fg = c.fg.hex },
        },
        replace = {
          a = { bg = c.r.da(30).sa(-50).hex, fg = c.bg.hex, gui = "bold" },
          b = { bg = c.bg.li(6).hex, fg = c.r.sa(-10).hex },
          c = { bg = c.bg.li(2).hex, fg = c.fg.hex },
        },
        command = {
          a = { bg = c.y.da(30).sa(-50).hex, fg = c.bg.hex, gui = "bold" },
          b = { bg = c.bg.li(6).hex, fg = c.y.sa(-10).hex },
          c = { bg = c.bg.li(2).hex, fg = c.fg.hex },
        },
      }
      require "lualine".setup {
        options = {
          theme = theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              padding = { left = 1, right = 1 },
              newfile_status = false,
              symbols = {
                modified = " ",
                readonly = " ",
                unnamed = " ",
              },
            },
          },
          lualine_x = { "lsp_status" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "oil" },
      }
    end,
  },
}
