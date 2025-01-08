class_name Camera extends Camera3D


@onready var table = Plane(Vector3(0, 1, 0), 2.59)

var camera = null


func _ready() -> void:
	camera = $"."
	Global.CAMERA = camera


func get_look_cords():
	var position2D = get_viewport().get_mouse_position()
	var position3D = table.intersects_ray(camera.project_ray_origin(position2D),camera.project_ray_normal(position2D))
	return position3D
