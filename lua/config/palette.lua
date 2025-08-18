local lush = require "lush"
local hsl = lush.hsl

local c = {
  bg = hsl(240, 20, 8),
  fg = hsl(230, 8, 55),
  r = hsl(340, 35, 40), -- red
  o = hsl(20, 30, 35), -- orange
  y = hsl(70, 30, 40), -- yellow
  g = hsl(170, 30, 30), -- green
  c = hsl(210, 30, 35), -- cyan
  b = hsl(230, 30, 40), -- blue
  p = hsl(290, 25, 40), -- purple
}
c.err = c.r.sa(10).ro(10)
c.warn = c.y.sa(10).ro(10)
c.hint = c.p.sa(10).ro(-10)
c.info = c.c.sa(10).ro(10)

return c
