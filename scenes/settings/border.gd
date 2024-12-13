extends Control


func _ready() -> void:
	var viewport_height = get_viewport().size[1]
	var border_height: int = viewport_height / 10
	self.custom_minimum_size[1] = border_height
