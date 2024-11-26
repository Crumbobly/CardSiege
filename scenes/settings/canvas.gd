extends CanvasLayer


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_settings"):
		show_settings()


func show_settings():
	self.visible = !self.visible
