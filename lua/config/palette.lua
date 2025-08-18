local lush = require "lush"
local hsl = lush.hsl

local c = {
  bg = hsl(240, 20, 8),
  fg = hsl(230, 10, 60),
  r = hsl(340, 35, 40), -- red
  o = hsl(20, 35, 45), -- orange
  y = hsl(70, 35, 45), -- yellow
  g = hsl(170, 35, 35), -- green
  c = hsl(210, 30, 50), -- cyan
  b = hsl(230, 30, 40), -- blue
  p = hsl(290, 25, 40), -- purple
}
c.err = c.r.sa(10).ro(10)
c.warn = c.y.sa(10).ro(10)
c.hint = c.p.sa(10).ro(-10)
c.info = c.c.sa(10).ro(10)

return c
