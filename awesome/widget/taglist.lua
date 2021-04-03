local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local mod = "Mod4"
local taglist_buttons =
  gears.table.join(
  awful.button(
    {},
    1,
    function(t)
      t:view_only()
    end
  ),
  awful.button(
    {mod},
    1,
    function(t)
      if _G.client.focus then
        _G.client.focus:move_to_tag(t)
      end
    end
  ),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button(
    {mod},
    3,
    function(t)
      if _G.client.focus then
        _G.client.focus:toggle_tag(t)
      end
    end
  ),
  awful.button(
    {},
    4,
    function(t)
      awful.tag.viewnext(t.screen)
    end
  ),
  awful.button(
    {},
    5,
    function(t)
      awful.tag.viewprev(t.screen)
    end
  )
)

return function(s)
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons,
    -- filter = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          layout = wibox.layout.fixed.vertical,
          {
            {
              {
                {
                  id = "text_role",
                  widget = wibox.widget.textbox
                },
                margins = 1,
                widget = wibox.container.margin
              },
              layout = wibox.layout.fixed.horizontal
            },
            left = 8,
            right = 8,
            widget = wibox.container.margin
          },
          {
            {
              left = 10,
              right = 10,
              top = 4,
              widget = wibox.container.margin
            },
            id = "overline",
            bg = "#ffffff",
            shape = gears.shape.rectangle,
            widget = wibox.container.background
          }
        },
        id = "background_role",
        widget = wibox.container.background
      },
      widget = wibox.container.margin,
      right = 5,
      create_callback = function(self, tag, _, _)
        local focused = false
        for _, x in pairs(awful.screen.focused().selected_tags) do
          if x.index == tag.index then
            focused = true
            break
          end
        end
        if focused then
          self.has_focused = true
          self:get_children_by_id("overline")[1].bg = beautiful.taglist_mouse_enter
        else
          self.has_focused = false
          self:get_children_by_id("overline")[1].bg = beautiful.taglist_bg_focus
        end -- self:get_children_by_id("index_role")[1].markup = "<b> " .. index .. " </b>"
        self:connect_signal(
          "mouse::enter",
          function()
            if self.bg ~= beautiful.taglist_mouse_enter then
              self.backup = self.bg
              self.has_backup = true
              self:get_children_by_id("overline")[1].bg = beautiful.taglist_mouse_enter
            end
            self.bg = beautiful.taglist_mouse_enter
            self:get_children_by_id("overline")[1].bg = beautiful.taglist_mouse_enter
          end
        )
        self:connect_signal(
          "mouse::leave",
          function()
            if self.has_backup then
              self.bg = self.backup
              if not self.has_focused then
                self:get_children_by_id("overline")[1].bg = beautiful.taglist_bg_focus
              end
            end
          end
        )
      end,
      update_callback = function(self, tag, _, _)
        local focused = false
        for _, x in pairs(awful.screen.focused().selected_tags) do
          if x.index == tag.index then
            focused = true
            break
          end
        end
        if focused then
          self:get_children_by_id("overline")[1].bg = beautiful.taglist_mouse_enter
          self.has_focused = true
        else
          self.has_focused = false
          self:get_children_by_id("overline")[1].bg = beautiful.taglist_bg_focus
        end
      end
    }
  }
end
