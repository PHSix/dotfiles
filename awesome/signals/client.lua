local theme = require("theme")
_G.client.connect_signal(
  "mouse::enter",
  function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
  end
)

_G.client.connect_signal(
  "focus",
  function(c)
    if c.class == "Wine" or c.class ==  "Ulauncher" then
      c.border_width = 0
      c.opacity = 1
      return
    end
    c.border_color = theme.border_focus
  end
)
_G.client.connect_signal(
  "unfocus",
  function(c)
    c.border_color = theme.border_normal
  end
)
