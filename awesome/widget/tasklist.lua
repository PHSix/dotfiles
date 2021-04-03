local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local tasklist_buttons =
  gears.table.join(
  awful.button(
    {},
    1,
    function(c)
      if c == _G.client.focus then
        c.minimized = true
      else
        c:emit_signal("request::activate", "tasklist", {raise = true})
      end
    end
  ),
  awful.button(
    {},
    3,
    function()
      awful.menu.client_list({theme = {width = 250}})
    end
  ),
  awful.button(
    {},
    4,
    function()
      awful.client.focus.byidx(1)
    end
  ),
  awful.button(
    {},
    5,
    function()
      awful.client.focus.byidx(-1)
    end
  )
)

return function(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = {
      spacing_widget = {
        {
          forced_width = 5,
          forced_height = 30,
          thickness = 7,
          color = beautiful.bg2,
          widget = wibox.widget.separator,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      spacing = 3,
      layout = wibox.layout.fixed.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      layout = wibox.layout.align.horizontal,
      {
        widget = wibox.widget.textbox,
        text = " "
      },
      {
        layout = wibox.layout.align.vertical,
        {
          wibox.widget.base.make_widget(),
          forced_height = 4,
          id = "upsideline",
          widget = wibox.container.background,
          bg = beautiful.purple
        },
        {
          {
            id = "clienticon",
            widget = awful.widget.clienticon
          },
          margins = 2,
          -- top = 10
          widget = wibox.container.margin
        }
      },
      {
        id = "tag_name",
        widget = wibox.widget.textbox,
        text = ""
      },
      {
        widget = wibox.widget.textbox,
        text = " "
      },
      create_callback = function(self, c, _, _)
        self:get_children_by_id("clienticon")[1].client = c
        if c == _G.client.focus then
          self:get_children_by_id("tag_name")[1].text = c.class
          self:get_children_by_id("upsideline")[1].bg = beautiful.purple
          self.bg = beautiful.dark2
        else
          self:get_children_by_id("tag_name")[1].text = ""
          self:get_children_by_id("upsideline")[1].bg = beautiful.bg2
          self.bg = beautiful.dark0
        end
      end,
      update_callback = function(self, c, _, _)
        self:get_children_by_id("clienticon")[1].client = c
        if c == _G.client.focus then
          self:get_children_by_id("tag_name")[1].text = c.class
          self:get_children_by_id("upsideline")[1].bg = beautiful.purple
          self.bg = beautiful.dark2
        else
          self:get_children_by_id("tag_name")[1].text = ""
          self:get_children_by_id("upsideline")[1].bg = beautiful.bg2
          self.bg = beautiful.dark0
        end
      end
    }
  }
end
