extends Control
class_name LoadGifControl


@onready var sprite2D = $LoadingGif
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var parent = self.get_parent_area_size()
	#var scale_factor = parent[0]/sprite2D.get_rect()
	sprite2D.visible = false

func start_anim():
	anim_player.play("loading_gif")

func stop_anim():
	anim_player.stop()
	
	
