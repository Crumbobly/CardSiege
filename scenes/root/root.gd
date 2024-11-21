extends Node3D
class_name Root

@export var start_scene: PackedScene = preload("res://scenes/auth/Auth3D.tscn")

func _ready() -> void:
	
	if $OnlyDebug.visible == true:
		return
	
	self.change_scene(start_scene.instantiate())


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_settings"):
		show_settings()


func show_settings():
	var settings = self.get_node("Settings").get_child(0)
	settings.visible = !settings.visible

		
func change_scene(scene: Node):
	for s in self.get_children():
		if s.name not in ["Camera3D", "DirectionalLight3D", "Wooden Table", "Settings"]:
			self.remove_child(s)
			
	self.add_child(scene)
