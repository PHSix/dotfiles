local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local dashboard =
  awful.popup {
  widget = {
    {
      {
        text = "foobar",
        widget = wibox.widget.textbox
      },
      {
        widget = wibox.widget.imagebox,
        image = gears.filesystem.get_configuration_dir() .. "/shuangpin.png"
      },
      {
        value = 0.5,
        forced_height = 30,
        forced_width = 100,
        widget = wibox.widget.progressbar
      },
      layout = wibox.layout.align.vertical
    },
    margins = 10,
    widget = wibox.container.margin
  },
  border_color = "#000000",
  border_width = 2,
  placement = awful.placement.centered,
  ontop = true,
  visible = false,
  forced_height = 300,
  forced_width = 300
}

return dashboard
