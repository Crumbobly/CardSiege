extends Button

var field: LineEdit
var eye_open: Texture2D = preload("res://assets/images/icons/eye_open.svg")
var eye_close: Texture2D = preload("res://assets/images/icons/eye_close.svg")
var opened = true
var darked = true

func _ready() -> void:
	field = get_parent().get_child(0)
	set_icon(eye_open)
	darken_icon()


func set_icon(texture: Texture2D):
	var img = texture.get_image()
	var resized_texture: ImageTexture = ImageTexture.new()
	img.resize(size[1]-8, size[1]-8)
	resized_texture.set_image(img)
	self.icon = resized_texture


# Затемняет текущую иконку
func darken_icon() -> void:
	apply_tint(0.12)
	darked = true

# Осветляет текущую иконку
func lighten_icon() -> void:
	apply_tint(0.2)
	darked = false
	

func apply_tint(tint_color: float):
	var image = self.icon.get_image()
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var color = image.get_pixel(x, y)
			color.r = tint_color	
			color.g = tint_color
			color.b = tint_color
			image.set_pixel(x, y, color)
			
	var tinted_texture = ImageTexture.new()
	tinted_texture.set_image(image)
	self.icon = tinted_texture
	
	
func _on_mouse_entered() -> void:
	lighten_icon()


func _on_mouse_exited() -> void:
	darken_icon()


func _on_pressed() -> void:
	if opened:
		field.secret = false
		set_icon(eye_close)
	else:
		field.secret = true
		set_icon(eye_open)
	
	if darked:
		darken_icon()
	else:
		lighten_icon()
		
	opened = !opened
