extends Label
class_name FontLabel

@export_group("Custom Font Properties")
@export var custom_font_size = 32
@export_enum(
	"NotoSans", 
	"Gesture",
	"Optimus",
	"Platin") \
	var custom_font: String


func _ready() -> void:
	apply_settings()


func apply_settings():
	self.add_theme_font_override("font", FontManager.get_font(custom_font))
	self.add_theme_font_size_override("font_size", FontManager.recalulate_size(custom_font_size))
