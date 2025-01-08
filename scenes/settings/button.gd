extends Button

func _ready() -> void:
	var parent_size = self.get_parent_control().get_parent_area_size()
	var scale_factor = parent_size[1] * 2 / self.size[1] 
	self.scale = Vector2(scale_factor, scale_factor)



func _on_mouse_entered() -> void:
	self.modulate = Color("#dadada")


func _on_mouse_exited() -> void:
	self.modulate = Color("#bdbdbd")
