local awful = require("awful")
local M = {
  layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
  },
  terminal = "GLFW_IM_MODULE=ibus;kitty",
  launch = "rofi",
  shift = "Shift",
  mod = "Mod4",
  ctrl = "Control",
}
return M
