extends Sprite2D

@export var svg_texture: Texture2D = preload("res://assets/images/gifs/loading_gif.svg")


func _ready() -> void:

	var img = svg_texture.get_image()
	var resized_texture = ImageTexture.new()
	resized_texture.set_image(img)
	
	self.texture = resized_texture
