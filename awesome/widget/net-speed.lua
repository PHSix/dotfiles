local wibox = require("wibox")
local gears = require("gears")
local prev_rx = 0
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local function net_down()
  return watch(
    [[bash -c "cat /sys/class/net/wlan0/statistics/rx_bytes"]],
    1,
    function(widget, stdout)
      local cur_rx = stdout
      if prev_rx == 0 then
        prev_tx = cur_rx
      end
      local down_speed = (tonumber(cur_rx) - tonumber(prev_rx)) / 1024
      if down_speed < 1 then
        down_speed = 0
        widget:set_text(string.format("%.2f KB", down_speed))
      elseif down_speed > 1024 then
        down_speed = down_speed / 1024
        widget:set_text(string.format("%.2f MB", down_speed))
      else
        widget:set_text(string.format("%.2f KB", down_speed))
      end
      prev_rx = cur_rx
    end
  )
end

local function init()
  local down_speed = net_down()
  return {
    {
      {
        {
          layout = wibox.layout.fixed.horizontal,
          down_speed,
          {
            layout = wibox.layout.align.vertical,
            {
              top = 9,
              widget = wibox.container.margin
            },
            {
              widget = wibox.widget.imagebox,
              image = gears.filesystem.get_configuration_dir() .. "/icons/down.svg",
              forced_width = 18,
              forced_height = 18
            }
          }
        },
        widget = wibox.container.margin,
        left = 10,
        right = 10
      },
      widget = wibox.container.background,
      bg = beautiful.blue,
      fg = beautiful.lightwhite
    },
    widget = wibox.container.margin,
    left = 5,
    right = 5
  }
end
return init
