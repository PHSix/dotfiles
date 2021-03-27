local conf = require("config")
local theme = require("theme")
local beautiful = require("beautiful")
beautiful.init(theme)
local gears = require("gears")
local awful = require("awful")
require("rules")
require("signals.screen")
require("awful.autofocus")
local naughty = require("naughty")
require("signals.client")
require("configuration.autorun")
if awesome.startup_errors then
  naughty.notify(
    {
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors,
      position = "bottom_right"
    }
  )
end
do
  local in_error = false
  awesome.connect_signal(
    "debug::error",
    function(err)
      if in_error then
        return
      end
      in_error = true
      naughty.notify(
        {
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err),
          position = "bottom_right"
        }
      )
      in_error = false
    end
  )
end
awful.layout.layouts = conf.layouts

awful.screen.connect_for_each_screen(require("configuration.top-bar"))

_G.root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))

local keys = require("configuration")
local globalkeys = gears.table.join({}, keys.keys)
local dashboard = require("configuration.dashboard")
globalkeys =
  gears.table.join(
  globalkeys,
  awful.key(
    {"Mod4"},
    "s",
    function()
      if dashboard.visible == true then
        dashboard.visible = false
      else
        dashboard.visible = true
      end
    end,
    {description = "toggle tag #", group = "dashboard"}
  )
)
_G.root.keys(globalkeys)

_G.client.connect_signal(
  "manage",
  function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_offscreen(c)
    end
  end
)
_G.client.connect_signal("manage", function (c)
  if c.class == "Gnome-boxes" then
    return
  end
  c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,5)
    end
end)

