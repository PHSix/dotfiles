local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local screen_geometry = awful.screen.focused().geometry
local dashboard =
  wibox(
  {
    ontop = true,
    visible = false,
    type = "splash",
    opacity = 0.8,
  }
)
if screen_geometry.height < screen_geometry.width then
  dashboard.width = screen_geometry.height * 4 / 5
  dashboard.height = screen_geometry.height * 3 / 5
  dashboard.x = (screen_geometry.width - dashboard.width) / 2
  dashboard.y = (screen_geometry.height - dashboard.height) / 2
else
  dashboard.width = screen_geometry.width * 4 / 5
  dashboard.height = screen_geometry.width * 3 / 5
end
dashboard:setup {
  layout = wibox.layout.flex.horizontal,
  {
    widget = wibox.container.background,
    bg = beautiful.purple,
    forced_width = 200
  },
  {
    widget = wibox.container.background,
    bg = beautiful.blue,
    forced_width = 200
  },
  {
    widget = wibox.container.background,
    bg = beautiful.purple,
    forced_width = 200
  }
}

return dashboard
