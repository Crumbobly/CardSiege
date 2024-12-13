extends Node

var _cached_fonts: Dictionary = {}

static var font_enum = {
	"NotoSans": "res://assets/fonts/noto-sans.regular.ttf", 
	"Gesture": "res://assets/fonts/Bright Gesture.otf",
	"Optimus": "res://assets/fonts/OptimusPrinceps.ttf",
	"Platin": "res://assets/fonts/MPlantin.ttf"
}

func get_font(font_name: String) -> FontVariation:
	var font_path = font_enum[font_name]
	if not _cached_fonts.has(font_name):
		var font: FontVariation = FontVariation.new()
		font.base_font = load(font_path)
		_cached_fonts[font_name] = font
		
	return _cached_fonts[font_name]


static func recalulate_size(base_font_size) -> int:
	var height = ProjectSettings.get_setting("display/window/size/viewport_height")
	# Берём fullhd как базовой разрешение
	var scale_factor = height / 1080.0
	var new_font_size = base_font_size * scale_factor
	return new_font_size
