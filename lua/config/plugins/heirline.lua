local function config()
  local conditions = require("heirline.conditions")
  local utils = require("heirline.utils")
  local colors = require("darkslate").opts.color
  colors = vim.tbl_extend("force", colors, {
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("Deleted").fg,
    git_add = utils.get_highlight("Added").fg,
    git_change = utils.get_highlight("Changed").fg,
  })

  local ViMode = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    static = {
      mode_names = {
        n =         "N  ",
        no =        "N? ",
        nov =       "N?c",
        noV =       "N?L",
        ["no\22"] = "N?B",
        niI =       "I>N",
        niR =       "R>N",
        niV =       "$>N",
        nt =        "NiT",
        ntT =       "T>N",
        v =         "Vc ",
        vs =        "Vcs",
        V =         "Vl ",
        Vs =        "Vls",
        ["\22"] =   "Vb ",
        ["\22s"] =  "Vbs",
        s =         "Sc ",
        S =         "Sl ",
        ["\19"] =   "Sb ",
        i =         "I  ",
        ic =        "IC ",
        ix =        "ICx",
        R =         "R  ",
        Rc =        "RC ",
        Rx =        "RCx",
        Rv =        "$  ",
        Rvc =       "$C ",
        Rvx =       "$Cx",
        c =         "C  ",
        cr =        "Co ",
        cv =        "X  ",
        cvr =       "Xo ",
        r =         "P  ",
        rm =        "P~ ",
        ["r?"] =    "P? ",
        ["!"] =     "Sh ",
        t =         "T  ",
      },
      mode_colors = {
        n = "green0",
        i = "blue0",
        v = "purple0",
        V = "purple1",
        ["\22"] = "purple2",
        c = "orange0",
        s = "cyan0",
        S = "cyan1",
        ["\19"] = "cyan2",
        R = "red0",
        r = "red0",
        ["!"] = "dark_green",
        t = "yellow0",
      },
    },
    hl = { fg = "dark7" },
    { provider = "[" },
    {
      provider = function(self)
        return self.mode_names[self.mode]
      end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bold = true }
      end,
    },
    { provider = "]" },
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }

  local FileIcon = {
    init = function(self)
      local filename = vim.fs.basename(self.filepath)
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension)
      if not self.icon or not self.icon_color then
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color_by_filetype(
          vim.filetype.match { buf = self.buf },
          { default = true }
        )
      end
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    provider = function(self)
      if self.filepath == "" then
        return "[?]"
      end
      return vim.fs.basename(self.filepath)
    end,
  }

  local FileNameModifer = {
    hl = function(self)
      local hl = {}
      if vim.bo[self.buf].modified then
        hl.italic = true
      end
      if (not vim.bo[self.buf].modifiable) or vim.bo[self.buf].readonly then
        hl.fg = "orange0"
        hl.bold = true
      end
      return hl
    end,
  }

  local BufferBlock = {
    init = function(self)
      self.buf = vim.api.nvim_get_current_buf()
      self.filepath = vim.api.nvim_buf_get_name(self.buf)
    end,

    FileIcon,
    utils.insert(FileNameModifer, FileName),
    { provider = "%<" },
  }

  local Ruler = {
    { provider = "%l" },
    { provider = "/", hl = { fg = "dark7" } },
    { provider = "%L", hl = { bold = true } },
    { provider = ":", hl = { fg = "dark8" } },
    { provider = "%c" },
  }

  local ScrollBar = {
    static = { sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
    provider = function(self)
      local cur_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor(cur_line / lines * (#self.sbar - 1)) + 1
      return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "blue0", bg = "bg_blue" },
  }

  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    hl = { fg = "dark8" },

    { provider = "@(" },
    {
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
        return table.concat(names, " ")
      end,
      hl = { fg = "green0" },
    },
    { provider = ")" },
  }

  local sev = vim.diagnostic.severity
  local Diagnostics = {
    condition = conditions.has_diagnostics,
    init = function(self)
      self.diags = {}
      for _, diag in ipairs(vim.diagnostic.get(0)) do
        self.diags[diag.severity] = (self.diags[diag.severity] or 0) + 1
      end
    end,
    update = { "DiagnosticChanged", "BufEnter" },

    {
      condition = function(self)
        return self.diags[sev.ERROR] ~= nil
      end,
      provider = function(self)
        return " !" .. self.diags[sev.ERROR]
      end,
      hl = { fg = "diag_error", bold = true },
    },

    {
      condition = function(self)
        return self.diags[sev.WARN] ~= nil
      end,
      provider = function(self)
        return " !" .. self.diags[sev.WARN]
      end,
      hl = { fg = "diag_warn" },
    },

    {
      condition = function(self)
        return self.diags[sev.INFO] ~= nil
      end,
      provider = function(self)
        return " :" .. self.diags[sev.INFO]
      end,
      hl = { fg = "diag_info" },
    },

    {
      condition = function(self)
        return self.diags[sev.HINT] ~= nil
      end,
      provider = function(self)
        return " ?" .. self.diags[sev.HINT]
      end,
      hl = { fg = "diag_hint" },
    },
  }

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = (self.status_dict.added or 0) > 0
        or (self.status_dict.removed or 0) > 0
        or (self.status_dict.changed or 0) > 0
    end,

    { provider = " '", hl = { fg = "dark8" } },

    {
      provider = function(self)
        return self.status_dict.head
      end,
      hl = { fg = "green0", bold = true },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = "[",
      hl = { fg = "dark10" },
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ("+" .. count)
      end,
      hl = { fg = "git_add" },
    },
    {
      provider = function(self)
        local space = ""
        if (self.status_dict.added or 0) > 0 then
          space = space .. " "
        end
        local count = self.status_dict.removed or 0
        return count > 0 and (space .. "-" .. count)
      end,
      hl = { fg = "git_del" },
    },
    {
      provider = function(self)
        local space = ""
        if (self.status_dict.added or 0) > 0 or (self.status_dict.removed or 0) > 0 then
          space = space .. " "
        end
        local count = self.status_dict.changed or 0
        return count > 0 and (space .. "~" .. count)
      end,
      hl = { fg = "git_change" },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = "]",
      hl = { fg = "dark10" },
    },
  }

  local Space = { provider = "  " }

  require("heirline").setup {
    opts = { colors = colors },
    ---@diagnostic disable-next-line: missing-fields
    statusline = {
      { provider = " " },
      ViMode,
      Git,
      Space,
      BufferBlock,
      Diagnostics,
      { provider = "%=" },
      LSPActive,
      Space,
      Ruler,
      Space,
      ScrollBar,
      { provider = " " },
    },
  }
end

return {
  "rebelot/heirline.nvim",
  dependencies = {
    "SomeCoder99/darkslate.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = config,
}
