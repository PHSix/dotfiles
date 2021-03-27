local wibox = require('wibox')
local gears = require("gears")
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi
local watch = require('awful.widget.watch')

local cpu = wibox.widget.textbox()
local total_prev = 0
local idle_prev = 0
local cpu_watch = function ()
  watch([[bash -c "cat /proc/stat | grep '^cpu '"]], 1, function(_, stdout)
    local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
        stdout:match('(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - idle_prev
    local diff_total = total - total_prev
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    cpu.text =  math.floor(diff_usage) .. '%'

    total_prev = total
    idle_prev = idle
    collectgarbage('collect')
end)
end


return function ()
  cpu_watch()
  return {
      {
        {
          {
            layout = wibox.layout.align.horizontal,
            {
              layout = wibox.layout.align.vertical,
              wibox.container.margin(wibox.widget({
                widget = wibox.widget.imagebox,
                image = gears.filesystem.get_configuration_dir() .. "/icons/cpu.svg",
                forced_width = 20,
                forced_height = 20
              }),0, 0, 7, 3),
            },
            wibox.widget.textbox(" : "),
            cpu,
          },
          left = 10,
          right = 10,
          widget = wibox.container.margin
        },
        widget = wibox.container.background,
        bg = beautiful.darkcyan,
        fg = beautiful.lightwhite
      },
      left = 5,
      right = 5,
      widget = wibox.container.margin
    }
end

