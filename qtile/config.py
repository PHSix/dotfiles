
from typing import List  # noqa: F401
from libqtile import qtile
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile import hook
import subprocess

import os

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('/home/ph/.config/qtile/autostart.sh')
    subprocess.call(["sh",home])

mod = "mod4"
terminal = "st"
launcher = "rofi -show run"


keys = [
    Key([mod], "j", lazy.layout.next(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.previous(),
        desc="Move focus up in stack pane"),
    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.window.toggle_floating(),
        desc="Floating now you use pane"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.spawn(launcher), desc="Launch rofi"),
    Key([mod], "c", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Set now use pane fullscreen"),
    Key([mod], "n", lazy.spawn("feh --randomize --bg-fill ~/Pictures/wallpapers"), desc="Change wallpapers")
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    # layout.Max(),
    # layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(
        margin = 2,
        border_focus = "#dfe6e9",
        border_width = 3,
    ),
    layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Fura Code Nerd Font Mono',
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    highlight_method = "line",
                    background = "6c5ce7",
                    highlight_color = ['a29bfe'],
                    active = "130f40",
                    hide_unused = True,
                    padding_x = 5,
                ),
                widget.WindowTabs(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    show_state=False,
                    background = "2d3436",
                    fmt=""
                ),
                widget.Volume(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    background = "474787",
                    fmt = " : {}"
                ),
                widget.ThermalSensor(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    background = "e17055",
                    fmt = " : {}"
                ),
                widget.Memory(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    format = " : {MemUsed}M/{MemTotal}M",
                    background = "26de81",
                ),
                widget.CPU(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    format = " :{load_percent}%",
                    background = "45aaf2",
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Wlan(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    interface = "wlp9s0",
                    format = ": {essid}",
                    background = "a55eea",
                ),
                widget.Net(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    interface = "wlp9s0",
                    format = ":{down} :{up}",
                    background = "a55eea",
                ),
                widget.Clock(
                    font = "JetBrains Mono Medium",
                    fontsize = 18,
                    format='  :%Y-%m-%d %p %I:%M',
                    background = "ffb8b8"
                ),
                widget.Battery(
                    charge_char = "⚡:",
                    discharge_char = " :",
                    full_char = " :",
                    font = "Fura Code Nerd Font",
                    fontsize = 18,
                    format = '{char}{percent:1.0%}',
                    background = "1B9CFC"
                ),
                widget.Systray(
                    background = "2d3436"
                ),
            ],
    30,
),
),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "Qtile"


