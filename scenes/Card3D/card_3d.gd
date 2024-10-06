class_name Card3D extends Node3D

@onready var highligh_collision = $StaticBody3D/HighllightCollision
@onready var card_name_lbl = $CardNameLbl

@export var is_highlight: bool = false
@export var height_offset: float = 0.0
@export var is_drag = false
@export var pos_in_hand = null
@export var angle_in_hand = null
@export var last_pos = null

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
	
	tween.tween_property(self, "scale", Vector3(1.2, 1.2, 1.2) , 0.1)
	tween.tween_property(self, "rotation", Vector3(0, 0, 0) , 0.1)
	tween.tween_property(self, "position:y", pos_in_hand[1] + Global.HIGHLIGHT_OFFSET_HEIHT + height_offset, 0.1)
	last_pos = [pos_in_hand[0], pos_in_hand[1] + Global.HIGHLIGHT_OFFSET_HEIHT + height_offset]


# Когда много карт как переключать???

func unhighlight():
	if is_highlight:
		var tween = create_tween().set_parallel(true)
		is_highlight = false
		highligh_collision.position.y += Global.HIGHLIGHT_OFFSET_HEIHT + height_offset
		
		tween.tween_property(self, "scale", Vector3(1, 1, 1) , 0.1)
		tween.tween_property(self, "rotation_degrees", angle_in_hand , 0.1)
		tween.tween_property(self, "position:y", pos_in_hand[1], 0.1)
		last_pos = pos_in_hand
		

func anim_set_pos_x(x):
	var tween = create_tween()
	tween.tween_property(self, "position:x", x, 0.1)


func anim_set_pos_y(y):
	var tween = create_tween()
	tween.tween_property(self, "position:y", y, 0.1)


func set_anim_rotation_degrees(angle):
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", angle, 0.1)


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
