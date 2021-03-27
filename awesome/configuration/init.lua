local awful = require("awful")
local conf = require("config")
local mod = conf.mod or "Mod4"
local ctrl = conf.ctrl or "Control"
local shift = conf.shift or "Shift"
local join = require("gears").table.join
local map_key = require("awful").key
local keys = {}
local clientkeys = require("configuration.client")
local set_wallpaper = require("signals.screen")
local func = require("configuration.func")

local key_list = {
  -- awesome wm group
  map_key({mod, shift}, "e", func.quit, {description = "Quit from awesome wm", group = "awesome"}),
  map_key({mod, shift}, "r", func.restart, {description = "Hot reload awesome wm configure", group = "awesome"}),
  map_key({mod}, "w", set_wallpaper, {description = "Hot reload awesome wm configure", group = "awesome"}),
  -- tags
  map_key({mod, shift}, "h", func.focus_prev_tag, {description = "Focus next tag.", group = "tag"}),
  map_key({mod, shift}, "l", func.focus_next_tag, {description = "Focus next tag.", group = "tag"}),
  -- client
  map_key({mod}, "j", func.focus_next_client, {description = "Focus next.", group = "client"}),
  map_key({mod}, "k", func.focus_prev_client, {description = "Focus prev.", group = "client"}),
  -- launcher
  map_key({mod}, "Return", func.terminal, {description = "Open a kitty termianal.", group = "launcher"}),
  map_key({mod, shift}, "Return", func.terminal_st, {description = "Open a kitty termianal.", group = "launcher"}),
  map_key({mod}, "d", func.launcher, {description = "Start rofi launcher.", group = "launcher"}),
  map_key({mod}, "n", func.layout_next, {description = "select next layout", group = "launcher"}),
  map_key({mod}, "p", func.layout_prev, {description = "select prev layout", group = "launcher"}),
  map_key({mod, shift}, "k", func.swap_with_next, {description = "Swap to child", group = "client"}),
  map_key({mod, shift}, "j", func.swap_with_prev, {description = "Swap to father.", group = "client"}),
  map_key({mod}, "u", func.focus_next_screen, {description = "Focus to the next screen", group = "screen"}),
  map_key({mod}, "h", func.increment_client, {description = "Increment window size", group = "client"}),
  map_key({mod}, "l", func.decrement_client, {description = "Decrement window size", group = "client"}),
  map_key({mod}, "b", func.go_back, {description = "Go to back tag.", group = "tag"}),
  map_key({}, "#122", func.volume_lower, {description = "Lower volumn", group = "awesome"}),
  map_key({}, "#123", func.volume_rasie, {description = "Rasie volume", group = "awesome"}),
  map_key({}, "#232", func.backlight_down, {description = "Backlight down", group = "awesome"}),
  map_key({}, "#233", func.backlight_up, {description = "Backlight up", group = "awesome"})
}
for _, t in pairs(key_list) do
  keys = join(keys, t)
end
--
-- tag operation
--
for i = 1, 9 do
  local ltag = i + 9
  keys =
    join(
    keys,
    map_key(
      {mod},
      "#" .. ltag,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          local focus_tag = _G.client.focus.first_tag
          if tag == focus_tag then
            awful.tag.history.restore()
            return
          end
          awful.screen.focused().tags[i]:view_only()
        else
          awful.screen.focused().tags[i]:view_only()
        end
      end,
      {description = "view tag #" .. i, group = "tag"}
    ),
    map_key(
      {mod, shift},
      "#" .. ltag,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
            awful.screen.focused().tags[i]:view_only()
          end
        end
      end,
      {description = "move focused client to tag #" .. i, group = "tag"}
    )
  )
end

return {
  keys = keys,
  clientkeys = clientkeys
}
