local naughty = require("naughty")
local awful = require("awful")

local volume = {}

function volume.show_notify()
  awful.spawn.easy_async_with_shell(
    [[amixer get Master | grep "Mono: Playback"]],
    function(stdout, _, _, _)
      local cur_volume = string.match(stdout, "[0-9]+")
      naughty.notify(
        {
          timeout = 3,
          text = "Volume: " .. cur_volume,
          font = "FiraCode 12"
        }
      )
    end
  )
end

return volume
