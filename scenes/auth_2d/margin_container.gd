extends MarginContainer


func _ready()-> void:
	var view = get_viewport_rect().size
	self.custom_minimum_size = Vector2i(view[0]/3, view[1])
	$Panel.custom_minimum_size = self.custom_minimum_size + Vector2(75,75)
