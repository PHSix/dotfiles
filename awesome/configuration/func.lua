local cmd = require("awful").spawn
local conf = require("config")
local awful = require("awful")
local hotkeys_popup = awful.hotkeys_popup
local func = {}
function func.quit()
  cmd("killall v2ray")
  awesome.quit()
end
function func.restart()
  awesome.restart()
end
function func.terminal()
  cmd(conf.terminal)
end
function func.terminal_st()
  cmd("st")
end
function func.launcher()
  if conf.launch == "rofi" then
    cmd("rofi -show run")
  else
    cmd(conf.launch)
  end
end
function func.focus_next_client()
  awful.client.focus.byidx(1)
end
function func.focus_prev_client()
  awful.client.focus.byidx(-1)
end
function func.swap_with_next()
  awful.client.swap.byidx(1)
end
function func.swap_with_prev()
  awful.client.swap.byidx(-1)
end

function func.focus_next_screen()
  awful.screen.focus_relative(1)
end

function func.increment_client()
  awful.tag.incmwfact(0.05)
end
function func.decrement_client()
  awful.tag.incmwfact(-0.05)
end
function func.go_back()
  awful.tag.history.restore()
end

function func.hotkey()
  hotkeys_popup.show_help(nil, awful.screen.focused())
end

function func.layout_next()
  awful.layout.inc(1)
end
function func.layout_prev()
  awful.layout.inc(-1)
end
function func.focus_next_tag()
  for _, v in pairs(awful.screen.focused().tags) do
    if #v:clients() > 0 then
      v:view_only()
    end
  end
end
function func.focus_prev_tag()
  -- awful.screen.focused().selected_tag:view_only()
  -- local t = nil
  -- for _, v in pairs(awful.screen.focused().tags) do
  --   if #v:clients() > 0 and t ~= nil then
  --     v:view_only()
  --   end
  --   t = v
  -- end
end

function func.volume_rasie()
  cmd("amixer set Master playback 5+")
end

function func.volume_lower()
  cmd("amixer set Master playback 5-")
end

function func.backlight_down()
  cmd("backlight_control -10")
end
function func.backlight_up()
  cmd("backlight_control +10")
end
return func
