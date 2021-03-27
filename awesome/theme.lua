local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")

local theme = {}

theme.bg0 = "#213039"
theme.bg1 = "#242B48"
theme.bg2 = "#343F4C"
theme.dark0 = "#374D51"
theme.dark1 = "#1e272e"
theme.dark2 = "#34495e"
theme.white = "#d2dae2"
theme.lightwhite = "#ffffff"
theme.lightred = "#ff7979"
theme.red = "#ee5253"
theme.darkred = "#b33939"
theme.lightgreen = "#BBE67E"
theme.green = "#78e08f"
theme.darkgreen = "#218c74"
theme.cyan = "#12CBC4"
theme.darkcyan = "#38ada9"
theme.purple = "#D4BFFF"
theme.clearblue = "#40ffff"
theme.lightblue = "#34ace0"
theme.blue = "#227093"
theme.darkblue = "#3B3B98"
theme.orange = "#FEA47F"
theme.darkorange = "#F97F51"
theme.lightyellow = "#f9ca24"
theme.yellow = "#ffeaa7"
theme.darkyellow = "#ffb142"
theme.darkgray = "#84817a"
theme.gray = "#747d8c"
theme.pink = "#f78fb3"

theme.font = "JetBrains Mono Medium 10"
theme.hotkeys_font = "JetBrains Mono Medium 10"
theme.hotkeys_description_font = "JetBrains Mono Medium 10"
theme.top_bar_font = "FiraCode Nerd Font 10"

theme.bg_normal = theme.bg0
theme.bg_focus = theme.bg0
theme.bg_urgent = theme.bg0
theme.bg_minimize = theme.bg0
theme.bg_systray = theme.bg0

theme.fg_normal = "#cccccc"
theme.fg_focus = "#ffffff"
theme.fg_urgent = "#ffffff"
theme.fg_minimize = "#ffffff"

-- 设置窗口间隔
theme.useless_gap = dpi(2)
theme.border_width = dpi(2)
theme.border_normal = "#000000"
theme.border_focus = theme.white
theme.border_marked = "#3498db"

-- taglist
theme.taglist_bg_focus = theme.bg0
theme.taglist_fg_focus = theme.lightwhite
theme.taglist_bg_occupied = theme.bg0
theme.taglist_fg_occupied = theme.gray
theme.taglist_bg_volatile = theme.bg0
theme.taglist_bg_empty = theme.bg0
theme.taglist_font = "JetBrains Mono 12"
theme.taglist_mouse_enter = theme.clearblue

-- tasklist

theme.tasklist_font = "JetBrains Mono 16"

theme.wallpaper = function()
  math.randomseed(os.time())
  local num = math.random(1, 16)
  return gfs.get_configuration_dir() .. "/wallpapers/" .. num .. ".jpg"
end

theme.icon_theme = nil

-- layoutbox
theme.layout_tile = gfs.get_configuration_dir() .. "/icons/layout/tile.png"
theme.layout_max = gfs.get_configuration_dir() .. "/icons/layout/max.png"
theme.layout_floating = gfs.get_configuration_dir() .. "/icons/layout/floating.png"

return theme
