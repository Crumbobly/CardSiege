extends fontABS
class_name MiddleFont

@export var dynamic_font_size = 24

func _init() -> void:
	if self.resolution <= Vector2i(1280, 720):
		dynamic_font_size = 16
		
	elif self.resolution  <= Vector2i(1440,900):
		dynamic_font_size = 20
		
	elif self.resolution  <= Vector2i(1920,1080):
		dynamic_font_size = 24
		
	else:
		dynamic_font_size = 28

	self.font_size = dynamic_font_size
