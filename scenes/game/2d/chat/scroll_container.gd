extends ScrollContainer


func _init() -> void:
	var width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height = self.size[1]
	var new_size = Vector2(width/2.5, height)
	self.set_custom_minimum_size(new_size)
	self.set_size(new_size)
