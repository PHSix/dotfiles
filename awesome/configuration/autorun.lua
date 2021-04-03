local awful = require("awful")
do
  local cmds = {
    "killall picom",
    "killall nm-applet",
    "nm-applet",
    "fcitx5",
    "killall clipit",
    "clipit",
    "udiskie",
    "xfce4-power-manager",
    -- "picom  --experimental-backends"
    "picom  --experimental-backends",
    "optimus-manager-qt"
  }
  for _, i in pairs(cmds) do
    awful.spawn(i)
  end
end
