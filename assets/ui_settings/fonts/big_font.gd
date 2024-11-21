extends fontABS


@export var dynamic_font_size = 32

func _init() -> void:
	if self.resolution <= Vector2i(1280, 720):
		dynamic_font_size = 24
		
	elif self.resolution  <= Vector2i(1440,900):
		dynamic_font_size = 28
		
	elif self.resolution  <= Vector2i(1920,1080):
		dynamic_font_size = 32
		
	else:
		dynamic_font_size = 36
	self.font_size = dynamic_font_size
