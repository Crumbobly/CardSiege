class_name FontStatic

# Разрешения с размерами шрифтов для h0..h6
static var font_sizes = {
	"low": [64, 48, 37, 28, 21, 16, 12],     # Для низких разрешений (1280x720 и ниже)
	"medium": [72, 54, 42, 32, 24, 18, 14],  # Для средних разрешений (до 1440x900)
	"high": [80, 60, 47, 35, 27, 20, 15],    # Для высоких разрешений (до 1600x900)
	"full_hd": [96, 72, 56, 42, 32, 24, 18], # Для Full HD (1920x1080)
	"ultra_hd": [128, 96, 75, 56, 43, 32, 24], # Для разрешений до 2560x1080
	"wqhd": [172, 129, 100, 75, 57, 43, 32]  # Для разрешений 3440x1440 и выше
}

static func get_resolution_category(resolution: Vector2i) -> String:

	if resolution.x <= 1280 and resolution.y <= 720:
		return "low"
	elif resolution.x <= 1440 and resolution.y <= 900:
		return "medium"
	elif resolution.x <= 1600 and resolution.y <= 900:
		return "high"
	elif resolution.x <= 1920 and resolution.y <= 1080:
		return "full_hd"
	elif resolution.x <= 2560 and resolution.y <= 1080:
		return "ultra_hd"
	else:
		return "wqhd"


static func get_new_size(h_num) -> int:

	var _height = ProjectSettings.get_setting("display/window/size/viewport_height")
	var _width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var resolution = Vector2i(_width, _height)
	
	var category = get_resolution_category(resolution)
	var base_size = font_sizes[category][h_num]
	
	return base_size
