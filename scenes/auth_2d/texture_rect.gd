extends TextureRect

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
	self.texture = texture_list[texture_index]
