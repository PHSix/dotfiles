local awful = require("awful")
local map_key = require("awful").key
local join = require("gears").table.join
local conf = require("config")
local mod = conf.mod or "Mod4"
local ctrl = conf.ctrl or "Control"
local shift = conf.shift or "Shift"
local clientkeys = {}
local client_list = {
  map_key(
    {mod},
    "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "Fullscreen of a client window"}
  ),
  map_key(
    {mod},
    "q",
    function(c)
      c:kill()
    end
  ),
  map_key(
    {mod},
    "space",
    function(c)
      c.floating = not c.floating
      c:raise()
    end,
    {description = "Toggle floating.", group = "client"}
  ),
  map_key(
    {mod},
    "i",
    function(c)
      local t = awful.client.getmaster(awful.screen.focused())
      c:swap(t)
    end,
    {description = "Move toggle client to the master.", group = "client"}
  ),
  map_key(
    {mod},
    "p",
    function(c)
      c:move_to_screen()
    end,
    {description = "Move toggle client to the next screen.", group = "client"}
  ),
  map_key(
    {mod},
    "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "(un)maximize", group = "client"}
  ),
}
for _, t in pairs(client_list) do
  clientkeys = join(clientkeys, t)
end

return clientkeys
