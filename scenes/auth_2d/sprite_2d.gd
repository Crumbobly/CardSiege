extends Sprite2D


@onready var timer: Timer = $"../Timer"
var texture_list = [
	preload("res://assets/images/backgrounds/bg2.jpg"),
	preload("res://assets/images/backgrounds/bg3.jpg"),
	preload("res://assets/images/backgrounds/bg4.jpg")
]

var random_number_generator = RandomNumberGenerator.new()
var texture_index = random_number_generator.randi_range(0, 2)


func _ready() -> void:
	timer.connect("timeout", timer_timeout)
	timer.set_wait_time(60)
	timer.start()
	reset_image()


func timer_timeout():
	timer.set_wait_time(60)
	reset_image()


func reset_image():
	var parent = get_parent()
	self.texture = texture_list[texture_index]
	
	texture_index += 1
	if texture_index > 2:
		texture_index = 0
		
	if parent and parent is Control:
		var parent_size = parent.size
		if texture:
			var scale_factor = parent_size / texture.get_size()
			scale = scale_factor
			
	position = Vector2(parent.size[0]/2, parent.size[1]/2)
	visible = true
