from libqtile.config import Key, Screen, Group, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget


def init_keys():
    keys = [
        Key([mod], 'j', lazy.layout.down()),
        Key([mod], 'k', lazy.layout.up()),
        Key([mod, 'shift'], 'j', lazy.layout.shuffle_down()),
        Key([mod, 'shift'], 'k', lazy.layout.shuffle_up()),
        Key([mod], 'i', lazy.layout.grow()),
        Key([mod], 'm', lazy.layout.shrink()),
        Key([mod], 'n', lazy.layout.normalize()),
        Key([mod], 'o', lazy.layout.maximize()),
        Key([mod], 'f', lazy.window.toggle_fullscreen()),
        Key([mod], 'space', lazy.spawncmd(prompt=' ')),
        Key([mod], 'p', lazy.spawn('dmenu_run')),
        Key([mod], 'Return', lazy.spawn(terminal)),
        Key([mod], 'w',      lazy.window.kill()),
        Key([mod, 'shift'], 'r', lazy.restart()),
        Key([], 'XF86AudioRaiseVolume',
            lazy.spawn('amixer set -D pulse Master 5%+')),
        Key([], 'XF86AudioLowerVolume',
            lazy.spawn('amixer set -D pulse Master 5%-')),
        Key([], 'XF86AudioMute',
            lazy.spawn('amixer set -D pulse Master toggle')),
        Key([], 'XF86MonBrightnessUp', lazy.spawn('xbacklight + 10')),
        Key([], 'XF86MonBrightnessDown', lazy.spawn('xbacklight - 10')),
    ]

    return keys


def init_groups():
    def _group(i):
        keys.append(Key([mod], i, lazy.group[i].toscreen()))
        keys.append(Key([mod, 'shift'], i, lazy.window.togroup(i)))
        return Group(i)

    return [_group(str(i)) for i in range(1,10)]


def init_layouts():
    return [layout.MonadTall(border_width=1, border_focus='#6476B1')]


dgroups_key_binder = None
dgroups_app_rules = []

def init_widgets_defaults():
    return dict(
        font='Ubuntu Mono',
        fontsize=16
    )


def init_widgets():
    widgets = [
        widget.GroupBox(borderwidth=1, rounder=False, padding=0),
        widget.Prompt(),
        widget.WindowName(),
        widget.CPUGraph(
            border_width=0,
            width=50,
            samples=20,
            type='line',
            line_width=1,
        ),
        widget.MemoryGraph(
            graph_color='FF4500',
            border_width=0,
            width=50,
            samples=20,
            type='line',
            line_width=1,
        ),
        widget.NetGraph(
            graph_color='E9CF12',
            border_width=0,
            width=50,
            samples=20,
            type='line',
            line_width=1,
        ),
        widget.Volume(),
        widget.Battery(),
        widget.Clock('%d/%m/%Y  %I:%M %p'),
    ]

    return widgets

def init_bottom_bar():
    return bar.Bar(widgets=init_widgets(), size=20, opacity=0.5)

def init_screens():
    return [Screen(bottom=init_bottom_bar())]


if __name__ in ['config', '__main__']:
    mod = 'mod4'
    terminal = 'gnome-terminal'
    follow_mouse_focus = False
    bring_front_click = False
    cursor_warp = False
    floating_layout = layout.Floating()
    auto_fullscreen = True

    keys = init_keys()
    groups = init_groups()
    layouts = init_layouts()
    screens = init_screens()
    widget_defaults = init_widgets_defaults()

