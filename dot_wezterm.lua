local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 12
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.initial_cols = 120
config.font = wezterm.font("MonaspiceNe NFM", { weight = "Regular" })
config.color_scheme = "tokyonight_night"

config.send_composed_key_when_left_alt_is_pressed = true

-- Run zsh as a login shell regardless of the OS default shell
if wezterm.target_triple:find("darwin") then
	config.default_prog = { "/bin/zsh", "-l" }
else
	config.default_prog = { "/usr/bin/zsh", "-l" }
end

return config
