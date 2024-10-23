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

var for_debug

var is_mouse_over = false

func _ready() -> void:
	super._ready()
	$"../../Hand"._on_card_selected_for_field.connect(Callable($".", "collec"))
	$"../../Hand"._on_card_deselected_for_field.connect(Callable($".", "uncollec"))
	#$"../../Hand".on_drop_state_field.connect(Callable($".", "move_for_fall"))
	Events.connect("card_on_field", Callable($".","move_for_fall"))
	Events.connect("card_off_field", Callable($".", "precalculate_all_card_position"))
	$Area3D.connect("mouse_entered", Callable($Area3D, "on_mouse_entered"))
	$Area3D.connect("mouse_exited", Callable($Area3D, "on_mouse_exited"))
func on_mouse_exited():
	print("A")
	is_mouse_over = false
func on_mouse_entered():
	is_mouse_over = true
func precalculate_all_card_position():
	var coords = _get_cards_distribution()
	if(card_collection != null):
		recalculate_all_card_position(coords)
	
	
func move_for_fall():
		var coords = _get_cards_distribution()
		var _move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
		print(coords)
		if(coords != null):
			adjust_coords_pos(coords)
			if(on_selected_card != null):
				for i in len(coords):
					var card : Card3D = card_collection[i]
					card.my_tween_list.add_tween(_move_tween)
					if(on_selected_card.over_field == card.over_field):
						if(coords[i] < on_selected_card.over_field_coord_x):
							coords[i] -= 2	
						if(coords[i] > on_selected_card.over_field_coord_x):
							coords[i] += 2
						_move_tween.tween_property(card, "position:x", coords[i], 0.2)
	


	
func collec(card : Card3D):
	on_selected_card = card

	

func uncollec():
	on_selected_card = null



func recalculate_all_card_position(coords):
	
	var scale_tween : Tween = create_tween()
	var move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
	if coords == null:
		return
	
	
	adjust_coords_pos(coords)	
	super.recalculate_all_card_position(coords)	
	
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		card.my_tween_list.add_tween(scale_tween)
		scale_tween.set_ease(Tween.EASE_OUT).set_parallel(true)
		
		move_tween.tween_property(card, "position:x", coords[index], 0.2)
		#card.position.x = coords[index]
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
	
