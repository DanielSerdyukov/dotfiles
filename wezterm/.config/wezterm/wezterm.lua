local wezterm = require("wezterm")

wezterm.on("gui-startup", function()
  local tab, pane, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS NF")
config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "nightfox"

config.colors = {
  background = 'black',
}

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  font_size = 12.0,
}

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  { key = 'n',          mods = 'CMD', action = wezterm.action.DisableDefaultAssignment },
  { key = 'f',          mods = 'CMD', action = wezterm.action.DisableDefaultAssignment },
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
  -- Make Option-Right equivalent to Alt-f; forward-word
  { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
}

return config
