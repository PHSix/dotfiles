local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local function ram()
  return watch(
    'bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"',
    10,
    function(widget, stdout)
      local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
        stdout:match("(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)")
      if tonumber(used) > 1048576 * 2 then
        widget:set_text(string.format("%.2f GB", used / 1024 / 1024))
      elseif tonumber(used) < 1024 * 1024 / 2 then
        widget:set_text(string.format("%.2f KB", used))
      else
        widget:set_text(string.format("%.2f MB", used / 1024))
      end
    end
  )
end

return function()
  local ram_widget = ram()
  return {
    {
      {
        {
          layout = wibox.layout.align.horizontal,
          {
            {
              widget = wibox.widget.imagebox,
              image = gears.filesystem.get_configuration_dir() .. "/icons/memory.svg",
              forced_width = 20,
              forced_height = 20
            },
            top = 7,
            widget = wibox.container.margin,
          },
          {
            widget = wibox.widget.textbox,
            text = " : "
          },
          ram_widget,
        },
        left = 10,
        right = 10,
        widget = wibox.container.margin
      },
      widget = wibox.container.background,
      bg = beautiful.lightblue,
      fg = beautiful.lightwhite
    },
    left = 5,
    right = 5,
    widget = wibox.container.margin
  }
end
