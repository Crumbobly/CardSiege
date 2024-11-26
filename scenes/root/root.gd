extends Node3D
class_name Root


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_settings"):
		show_settings()


func show_settings():
	var settings = self.get_node("Settings").get_child(0)
	settings.visible = !settings.visible
