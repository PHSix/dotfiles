local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local TopBar = function(s)
  awful.tag({"dev", "vim", "web", "file", "chat", "git", "win", "music", "opt"}, s, awful.layout.layouts[1])
  -- layoutbox
  local layoutbox = awful.widget.layoutbox(s)
  -- taglist
  local taglist = require("widget.taglist")(s)
  -- tasklist
  local tasklist = require("widget.tasklist")(s)
  -- clock
  local clock = require("widget.clock")
  -- cpu
  local cpu = require("widget.cpu")()
  -- ram
  local ram = require("widget.ram")()
  local net = require("widget.net-speed")()
  -- systray
  local systray = wibox.widget.systray()
  local tray = wibox.container.margin(systray, 5, 5, 5, 5)
  -- battery
  local battery = require("widget.battery")()
  local system_details = {
    layout = wibox.layout.fixed.horizontal,
    net,
    cpu,
    ram,
    battery,
    clock,
    tray
  }
  local top_panel = awful.wibar({position = "top", screen = s, opacity = 0.8, shape = gears.shape.rounded_rect, border_width = 4})
  top_panel:setup {
    {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.align.horizontal,
        layoutbox,
        taglist
      },
      {
        {
          layout = wibox.layout.fixed.horizontal,
          tasklist
        },
        widget = wibox.container.background,
        bg = beautiful.bg2
      },
      system_details
    },
    layout = wibox.layout.align.vertical
  }
end
return TopBar
