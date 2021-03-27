local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local clock = wibox.widget.textclock("%m月%d日 %H:%M", 1)
local clock_template =
  wibox.widget(
  {
    {
      {
        layout = wibox.layout.align.horizontal,
        {
          {
            image = gears.filesystem.get_configuration_dir() .. "/icons/date.svg",
            widget = wibox.widget.imagebox,
            forced_width = 20,
            forced_height = 20,
          },
          left = 0,
          right = 0,
          top = 7,
          widget = wibox.container.margin
        },
        {
          widget = wibox.widget.textbox,
          text = " : "
        },
        clock
      },
      left = 10,
      right = 10,
      widget = wibox.container.margin
    },
    bg = beautiful.dark0,
    widget = wibox.container.background
  }
)

return wibox.container.margin(clock_template, 5, 5, 0, 0)
