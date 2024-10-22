extends CardLayout
class_name Field


@onready var shape: BoxShape3D = $Area3D/CollisionShape3D.shape
var circle_layut = CircleLayoutLogic.new(11.5)
@onready var collision_shape = $Area3D/CollisionShape3D
var line_layoyt = LineLayoutLogic.new()
@export var card_size : float = .7
var on_selected_card : Card3D

@export var move_offcet_for_drop : float = 1.5
var m_p

func _ready() -> void:
	super._ready()
	$"../../Hand"._on_card_selected_for_field.connect(Callable($".", "collec"))
	$"../../Hand"._on_card_deselected_for_field.connect(Callable($".", "uncollec"))
	$"../../Hand".on_drop_state_field.connect(Callable($".", "move_for_fall"))

func collec(card : Card3D):
	on_selected_card = card

	

func uncollec():
	on_selected_card = null

func move_for_fall():
	var coords = line_layoyt.distribute_points_with_max_distance(len(card_collection), collision_shape)
	var move_cords = coords
	var pos_x
	if(on_selected_card != null):
		if(on_selected_card.over_field != null):
			pos_x = m_p.x
			var max_min = -100
			var min_plus = 100
			print(pos_x)
			print(coords)
			for i in range(len(coords)):
				if(pos_x <= coords[i]):
					if(min_plus >= coords[i]):
						min_plus = i
				if(pos_x >= coords[i]):
					if(max_min <= coords[i]):
						max_min = i
			
			for i in range(len(move_cords)):
				if(i <= max_min):
					move_cords[i] = move_cords[i] - move_offcet_for_drop
				elif (i >= min_plus):
					move_cords[i] += move_cords[i] + move_offcet_for_drop
		
			for i in range(len(card_collection)):
					var card: Card3D = card_collection[i]
					var move_tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
					card.my_tween_list.add_tween(move_tween)
					move_tween.tween_property(card, "position:x", move_cords[i], 0.4)
	elif on_selected_card == null :
			for i in range(len(card_collection)):
					var card: Card3D = card_collection[i]
					var move_tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
					card.my_tween_list.add_tween(move_tween)
					move_tween.tween_property(card, "position:x", coords[i], 0.4)		

func recalculate_all_card_position(coords):
	var scale_tween : Tween = create_tween()
	if coords == null:
		return
	
	
	adjust_coords_pos(coords)	
	super.recalculate_all_card_position(coords)	
	
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		card.my_tween_list.add_tween(scale_tween)
		scale_tween.set_ease(Tween.EASE_OUT).set_parallel(true)
		
		
		card.position.x = coords[index]
		card.global_position.y = self.position.y
		scale_tween.tween_property(card, "scale",Vector3(0.4,0.4,0.4), 0.2)


func adjust_coords_pos(coord):
	if(len(coord) % 2 == 0):
		return 0
	else :
		for i in range(len(coord)):
			if coord[i] == 0:
				pass
			if coord[i] < 0:
				coord[i] -= card_size
			if coord[i] > 0:
				coord[i] += card_size


func _get_cards_distribution():
	line_layoyt._get_collider_corner(collision_shape)
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = line_layoyt.distribute_points_with_max_distance(current_card_count, collision_shape)
	return coords
	


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if(event is InputEventMouseMotion):
		m_p = event_position
