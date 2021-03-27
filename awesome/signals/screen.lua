local theme = require("theme")
local awful = require("awful")
local gears = require("gears")
local function set_wallpaper(s)
  -- Wallpaper
  if theme.wallpaper then
    local wallpaper = theme.wallpaper()
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end
local function set_screen_wallpaper()
  awful.screen.connect_for_each_screen(
    function(s)
      set_wallpaper(s)
    end
  )
end
set_screen_wallpaper()
return set_screen_wallpaper
-- gears.timer(
--   {
--     timeout = 3,
--     call_now = false,
--     autostart = true,
--     callback = set_screen_wallpaper
--   }
-- )
-- screen.connect_signal("property::geometry", set_wallpaper)
