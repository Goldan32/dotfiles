-- hyprland.lua  (converted from hyprland.conf, targets Hyprland 0.55+)
-- Refer to https://wiki.hypr.land/configuring/ for more information.
--
-- Editor completion: Hyprland ships LuaCATS stubs at /usr/share/hypr/stubs/hl.meta.lua

local home = os.getenv("HOME")

-------------------
---- PLUGINS ------
-------------------
-- hy3 must be loaded before anything below touches it (layout = "hy3",
-- plugin.hy3.* config keys, hl.plugin.hy3.* dispatchers).
hl.plugin.load("/run/current-system/sw/lib/libhy3.so")
local hy3 = hl.plugin.hy3

------------------
---- MONITORS ----
------------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "PATH=$HOME/.local/bin:$PATH; $HOME/.config/hypr/scripts/launch_kitty.sh"
local terminalNew = "$HOME/.local/bin/kitty"
local fileManager = "thunar"
local menu = "rofi -theme normal -show drun"
local browser = "firefox"
local soundSettings = "pavucontrol"
local bluetoothSettings = "blueman-manager"
local backupTerminal = "gnome-terminal"
local lockScreen = "$HOME/.config/hypr/scripts/lock_screen.sh"
local wifiSettings = "wezterm --config-file $HOME/.config/wezterm/wezterm-hyprland.lua start -- nmtui"
local volumeScript = "$HOME/.config/hypr/scripts/volume.sh"
local timeScript = "$HOME/.config/hypr/scripts/time_and_battery.sh"
local laptopMonitorSwitch = "$HOME/.config/hypr/scripts/laptop_monitor_switch.sh toggle"
local switchAudio = "$HOME/.local/bin/switch-audio"
local threeWindows = "$HOME/.config/hypr/scripts/three-vertical.sh"

local exec = hl.dsp.exec_cmd

-- Machine-specific overrides (was: `source = $HOME/.config/hypr/corpo.conf`).
-- NOTE: corpo.conf must be rewritten as corpo.lua; a .conf file cannot be loaded from Lua.
do
  local corpo = home .. "/.config/hypr/corpo.lua"
  local f = io.open(corpo, "r")
  if f then
    f:close()
    dofile(corpo)
  end
end

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("cd $HOME/.local/start-page && python3 -m http.server 8088 --bind 127.0.0.1")
end)

-----------------------------
---- WINDOW RULES ----------
-----------------------------
hl.window_rule({
  name = "pavucontrol",
  match = { class = "^(org.pulseaudio.pavucontrol)$" },
  float = true,
  size = "740 1020",
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
local black = {
  [0] = "rgba(000000ff)",
  "rgba(1a1a1aff)",
  "rgba(333333ff)",
  "rgba(4d4d4dff)",
  "rgba(666666ff)",
  "rgba(808080ff)",
  "rgba(999999ff)",
  "rgba(b3b3b3ff)",
}
local white = {
  [0] = "rgba(ffffffff)",
  "rgba(f2f2f2ff)",
  "rgba(f6f1e7ff)",
  "rgba(d9d9d9ff)",
  "rgba(ccccccff)",
  "rgba(bfbfbfff)",
  "rgba(b3b3b3ff)",
  "rgba(a6a6a6ff)",
}

-- hy3 style
-- (Lua config uses the renamed `colors = { active_border = ... }` fields instead of `col.active.border`)
hl.config({
  plugin = {
    hy3 = {
      tabs = {
        height = 12,
        padding = 0,
        radius = 2,
        border_width = 1,
        text_padding = 2,
        blur = false,

        colors = {
          active = white[2],
          active_border = white[2],
          active_text = black[0],

          -- was `col.unfocused*`; closest hy3 field is "active tab on an unfocused monitor"
          active_alt_monitor = white[2],
          active_alt_monitor_border = white[2],
          active_alt_monitor_text = black[0],

          focused = black[3],
          focused_border = black[3],
          focused_text = black[0],

          inactive = black[2],
          inactive_border = black[2],
          inactive_text = white[0],
        },
      },
    },
  },
})

hl.config({
  general = {
    gaps_in = 1,
    gaps_out = 2,

    -- Switching left stays on left if last left is reached
    no_focus_fallback = true,

    border_size = 1,

    col = {
      active_border = white[2],
      inactive_border = black[3],
    },

    -- Resize windows by clicking and dragging on borders and gaps
    resize_on_border = true,
    extend_border_grab_area = 3,

    allow_tearing = false,

    layout = "hy3",
  },

  decoration = {
    rounding = 4,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    blur = {
      enabled = false,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    vrr = 0,
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

-- A lower number for SPEED means a faster animation
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "default", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slide" })

---------------
---- INPUT ----
---------------
hl.config({
  input = {
    kb_layout = "us,hu",
    kb_options = "grp:win_space_toggle,caps:swapescape",
    follow_mouse = 1,
    sensitivity = 0.7, -- -1.0 - 1.0, 0 means no modification.
    accel_profile = "flat",
    repeat_rate = 50,
    repeat_delay = 280,

    touchpad = {
      natural_scroll = true,
    },
  },
})

-- Per-device input
hl.device({ name = "razer-razer-deathadder-v2", sensitivity = -0.5 })
hl.device({ name = "razer-razer-deathadder-v2-1", sensitivity = -0.5 })
hl.device({ name = "compx-2.4g-receiver-mouse", sensitivity = -0.2 })
hl.device({ name = "logitech-m720-triathlon-1", sensitivity = 0.3 })

---------------------
---- KEYBINDINGS ----
---------------------

-- hy3 groups
hl.bind("ALT + A", hy3.make_group("v", { ephemeral = "force" }))
hl.bind("SHIFT + ALT + A", hy3.make_group("h", { ephemeral = "force" }))

-- Programs / misc
hl.bind("ALT + N", exec(terminal))
hl.bind("SHIFT + ALT + N", exec(terminalNew))
hl.bind("CONTROL + ALT + T", exec(backupTerminal))
hl.bind("ALT + W", hl.dsp.window.close())
hl.bind("SUPER + E", exec(fileManager))
hl.bind("SUPER + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + R", exec(menu))
hl.bind("SUPER + I", exec(menu))
hl.bind("ALT + B", exec(browser))
hl.bind("SUPER + HOME", exec(lockScreen))
hl.bind("SUPER + 2", exec(soundSettings))
hl.bind("SUPER + 1", exec(bluetoothSettings))
hl.bind("SUPER + 3", exec(wifiSettings))
hl.bind("SUPER + P", exec(laptopMonitorSwitch))
hl.bind("SUPER + Q", exec(timeScript))
hl.bind("SUPER + M", exec(switchAudio))
hl.bind("ALT + M", exec(threeWindows))

-- Move focus (right hand hjkl) and move windows
for key, dir in pairs({ H = "l", L = "r", K = "u", J = "d" }) do
  hl.bind("ALT + " .. key, hy3.move_focus(dir, { visible = true }))
  hl.bind("SHIFT + ALT + " .. key, hy3.move_window(dir, { once = true }))
end

-- Move focus (left hand), warping the cursor
for key, dir in pairs({ S = "l", G = "r", D = "u", F = "d" }) do
  hl.bind("ALT + " .. key, hy3.move_focus(dir, { visible = true, warp = true }))
end

-- Workspaces: { modifier, key, workspace }
local workspaces = {
  { "ALT", "U", 1 },
  { "ALT", "I", 2 },
  { "ALT", "O", 3 },
  { "ALT", "P", 4 },
  { "SUPER", "5", 5 },
  { "SUPER", "6", 6 },
  { "SUPER", "7", 7 },
  { "SUPER", "8", 8 },
  { "ALT", "9", 9 },
  { "SUPER", "4", 10 },
}
for _, w in ipairs(workspaces) do
  local mod, key, id = w[1], w[2], w[3]
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = id }))
  hl.bind(mod .. " + SHIFT + " .. key, hy3.move_to_workspace(tostring(id)))
end

-- Mouse side buttons / scroll through workspaces
hl.bind("mouse:275", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("mouse:276", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Resize active window (repeats while held)
hl.bind("CONTROL + SHIFT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind("CONTROL + SHIFT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind("CONTROL + SHIFT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind("CONTROL + SHIFT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Tab groups
hl.bind("ALT + T", hy3.make_group("tab"))
hl.bind("SHIFT + ALT + T", hy3.change_group("untab"))
hl.bind("ALT + R", hy3.focus_tab({ direction = "right" }))
hl.bind("ALT + E", hy3.focus_tab({ direction = "left" }))

-- Media player control
hl.bind("XF86AudioPlay", exec("playerctl play-pause"))
hl.bind("XF86AudioNext", exec("playerctl next"))
hl.bind("XF86AudioPrev", exec("playerctl previous"))

-- Volume controls with indicator
hl.bind("XF86AudioMute", exec(volumeScript .. " mute"))
hl.bind("XF86AudioLowerVolume", exec(volumeScript .. " down"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", exec(volumeScript .. " up"), { repeating = true })

-- Screenshots
-- Entire screen
hl.bind("SHIFT + Print", exec([[grim - | tee $HOME/.screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]))
-- Selected region
hl.bind("Print", exec([[grim -g "$(slurp)" - | tee $HOME/.screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]))
-- Active window (rewritten: the original only parsed the `at:` line, so the size was missing; needs jq)
hl.bind(
  "CTRL + Print",
  exec(
    [[grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | tee $HOME/.screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy]]
  )
)

-- Brightness
hl.bind(
  "XF86MonBrightnessUp",
  exec(
    [[bash -c 'brightnessctl set +5% && dunstify -r 9999 -h int:value:$(brightnessctl get | awk "{print int(\$1 * 100 / $(brightnessctl max))}") "Brightness"']]
  )
)
hl.bind(
  "XF86MonBrightnessDown",
  exec(
    [[bash -c 'brightnessctl set 5%- && dunstify -r 9999 -h int:value:$(brightnessctl get | awk "{print int(\$1 * 100 / $(brightnessctl max))}") "Brightness"']]
  )
)

-- Float, resize to 2300x1434 and center
hl.bind("SUPER + F", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.resize({ x = 2300, y = 1434 })) -- no `relative` = exact size
  hl.dispatch(hl.dsp.window.center())
end)
