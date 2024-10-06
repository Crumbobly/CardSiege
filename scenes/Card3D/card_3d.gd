class_name Card3D extends Node3D

@onready var highligh_collision = $StaticBody3D/HighllightCollision
@onready var card_name_lbl = $CardNameLbl

@export var is_highlight: bool = false
@export var height_offset: float = 0.0
@export var is_drag = false
@export var pos_in_hand = null
@export var angle_in_hand = null
@export var last_pos = null

@export var pos_duration : float = 0.5
@export var rotate_daration : float = .5
@export var highlight_duration : float = .5
@export var scale_duration : float = .5
signal mouse_entered(card: Card3D)
signal mouse_exited(card: Card3D)
signal left_click(card: Card3D)
signal dropped(card: Card3D)


func set_card_name(name):
	card_name_lbl.set_text(name)


func highlight():
	var tween = create_tween().set_parallel(true)
	is_highlight = true
	highligh_collision.position.y -= Global.HIGHLIGHT_OFFSET_HEIHT + height_offset
	
	if self.position.x != pos_in_hand[0] and self.position.y != pos_in_hand[1]:
		self.position.x = pos_in_hand[0]
		self.position.y = pos_in_hand[1]
	
	tween.set_ease(Tween.EASE_IN)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector3(1.2, 1.2, 1.2) , scale_duration)
	tween.tween_property(self, "rotation", Vector3(0, 0, 0) , pos_duration)
	tween.tween_property(self, "position:y", pos_in_hand[1] + Global.HIGHLIGHT_OFFSET_HEIHT + height_offset, pos_duration)
	last_pos = [pos_in_hand[0], pos_in_hand[1] + Global.HIGHLIGHT_OFFSET_HEIHT + height_offset]


# Когда много карт как переключать???

func unhighlight():
	if is_highlight:
		var tween = create_tween().set_parallel(true)
		is_highlight = false
		highligh_collision.position.y += Global.HIGHLIGHT_OFFSET_HEIHT + height_offset
		
		tween.set_ease(Tween.EASE_IN)
		tween.set_parallel(true)
		tween.tween_property(self, "scale", Vector3(1, 1, 1) , scale_duration)
		tween.tween_property(self, "rotation_degrees", angle_in_hand , rotate_daration)
		tween.tween_property(self, "position:y", pos_in_hand[1], pos_duration)
		last_pos = pos_in_hand
		

func anim_set_pos_x(x):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "position:x", x, pos_duration)


func anim_set_pos_y(y):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "position:y", y, pos_duration)


func set_anim_rotation_degrees(angle):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation_degrees", angle, rotate_daration)


func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	
	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:
			
			if event.pressed:
				left_click.emit(self)
				is_drag = true
				
			else:
				if is_drag:
					dropped.emit(self)
				is_drag = false


func _on_static_body_3d_mouse_entered() -> void:
	mouse_entered.emit(self)


func _on_static_body_3d_mouse_exited() -> void:
	mouse_exited.emit(self)
