extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var corner_radius: int = get_theme_stylebox("normal", "BigButton").get_corner_radius(2)
	add_theme_constant_override("margin_bottom", corner_radius)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
