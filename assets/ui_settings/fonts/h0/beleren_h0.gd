extends FontFile

@export var font_path: String = "res://assets/fonts/Beleren Small Caps.ttf"  

func _init() -> void:
	self.load_dynamic_font(font_path)
	self.set_fixed_size(FontStatic.get_new_size(0))
