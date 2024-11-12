extends CardLayout
class_name Field


@onready var collision_shape = $Area3D/CollisionShape3D
@onready var shape: BoxShape3D = $Area3D/CollisionShape3D.shape
@onready var hand =  $"../../Hand"

var circle_layut = CircleLayoutLogic.new(11.5)
var line_layoyt = LineLayoutLogic.new()
var card_size : float = .7
var curr_coords


func _ready() -> void:
	super._ready()

	
func precalculate_all_card_position():
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
	
func move_for_fall(hand_selected_card: Card3D):
	var coords = _get_cards_distribution()
	
	if(coords != null):
		
		adjust_coords_pos(coords)
		
		for i in len(coords):
			var card : Card3D = card_collection[i]
			if(coords[i] <= hand_selected_card.over_field_coord_x):
				coords[i] -= 2
			if(coords[i] >= hand_selected_card.over_field_coord_x):
				coords[i] += 2
		
		if coords != curr_coords:
			for i in len(coords):
				var card : Card3D = card_collection[i]
				var _move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
				_move_tween.tween_property(card, "position:x", coords[i], 0.2)

		curr_coords = coords


func recalculate_all_card_position(coords):
	
	if coords == null:
		return
	
	adjust_coords_pos(coords)	
	super.recalculate_all_card_position(coords)	

	for index in range(len(coords)):
		var scale_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
		var move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
		var card: Card3D = card_collection[index]
		move_tween.tween_property(card, "position:x", coords[index], 0.2)
		card.global_position.y = self.position.y
		scale_tween.tween_property(card, "scale", Vector3(0.4, 0.4, 0.4), 0.2)

	curr_coords = coords

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
	
