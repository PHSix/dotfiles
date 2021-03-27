local watch = require("awful.widget.watch")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function battery()
  return watch(
    "acpi -i",
    1,
    function(widget, stdout)
      for s in stdout:gmatch("[^\r\n]+") do
        local status, charge_str, _ = string.match(s, ".+: (%a+), (%d?%d?%d)%%,?(.*)")
        if status == "Charging" then
          widget:get_children_by_id("icon_top")[1].top = 9
          widget:get_children_by_id("battery_icon")[1].image =
            gears.filesystem.get_configuration_dir() .. "/icons/charging.svg"
          widget:get_children_by_id("battery_percentage")[1].text = " : " .. math.ceil(charge_str) .. "%"
          return
        elseif status == "Full" then
          widget:get_children_by_id("icon_top")[1].top = 7
          widget:get_children_by_id("battery_icon")[1].image =
            gears.filesystem.get_configuration_dir() .. "/icons/full.svg"
          widget:get_children_by_id("battery_percentage")[1].text = " : " .. math.ceil(charge_str) .. "%"
        elseif status == "Discharging" then
          charge_str = tonumber(charge_str) / 0.98
          widget:get_children_by_id("icon_top")[1].image = 9
          if charge_str >= 75 then
            widget:get_children_by_id("battery_icon")[1].image =
              gears.filesystem.get_configuration_dir() .. "/icons/battery-4.svg"
          elseif charge_str >= 50 then
            widget:get_children_by_id("battery_icon")[1].image =
              gears.filesystem.get_configuration_dir() .. "/icons/battery-3.svg"
          elseif charge_str >= 25 then
            widget:get_children_by_id("battery_icon")[1].image =
              gears.filesystem.get_configuration_dir() .. "/icons/battery-2.svg"
          else
            widget:get_children_by_id("battery_icon")[1].image =
              gears.filesystem.get_configuration_dir() .. "/icons/battery-1.svg"
          end
          widget:get_children_by_id("battery_percentage")[1].text = " : " .. math.ceil(charge_str) .. "%"
        end
      end
    end,
    wibox.widget(
      {
        layout = wibox.layout.align.horizontal,
        {
          {
            id = "battery_icon",
            widget = wibox.widget.imagebox,
            forced_width = 20,
            forced_height = 20
          },
          id = "icon_top",
          widget = wibox.container.margin,
          top = 9
        },
        {
          id = "battery_percentage",
          widget = wibox.widget.textbox
        }
      }
    )
  )
end

return function()
  local battery_widget = battery()
  return wibox.container.margin(
    wibox.widget(
      {
        wibox.container.margin(battery_widget, 10, 10, 0, 0),
        bg = beautiful.dark1,
        widget = wibox.container.background
      }
    ),
    5,
    5,
    0,
    0
  )
end
