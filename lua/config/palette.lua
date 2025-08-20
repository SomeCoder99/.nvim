local lush = require "lush"
local hsl = lush.hsl

---@type table
local c = {
  bg = hsl(240, 20, 10),
  fg = hsl(230, 8, 55),
  r = hsl(340, 30, 45), -- red
  o = hsl(30, 25, 40), -- orange
  y = hsl(90, 25, 45), -- yellow
  g = hsl(170, 25, 35), -- green
  c = hsl(210, 30, 45), -- cyan
  b = hsl(230, 30, 50), -- blue
  p = hsl(290, 25, 50), -- purple
}
c.err = c.r.sa(10).ro(10)
c.warn = c.y.sa(10).ro(10)
c.hint = c.p.sa(10).ro(-10)
c.info = c.c.sa(10).ro(10)

return c
