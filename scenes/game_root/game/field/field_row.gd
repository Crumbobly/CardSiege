extends CardLayout
class_name FieldRow


@onready var collision_shape = $Area3D/CollisionShape3D
@onready var hand =  $"../../Hand"

var line_layoyt = LineLayoutLogic.new()
var curr_coords

	
func precalculate_all_card_position():
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
	
func move_for_fall(hand_selected_card: Card3D):
	var coords = _get_cards_distribution()
	
	if(coords != null):
		
		for i in len(coords):
			var card : Card3D = card_collection[i]
			if(coords[i] <= hand_selected_card.over_field_coord_x):
				coords[i] -= 0.5
			if(coords[i] >= hand_selected_card.over_field_coord_x):
				coords[i] += 0.5
		
		if coords != curr_coords:
			for i in len(coords):
				var card : Card3D = card_collection[i]
				var _move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
				_move_tween.tween_property(card, "position:x", coords[i], 0.2)

		curr_coords = coords


func recalculate_all_card_position(coords):
	
	if coords == null:
		return

	super.recalculate_all_card_position(coords)	

	for index in range(len(coords)):
		var scale_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
		var move_tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)
		var card: Card3D = card_collection[index]
		move_tween.tween_property(card, "position:x", coords[index], 0.2)
		card.global_position.z = self.global_position.z
		scale_tween.tween_property(card, "scale", Vector3(0.07, 0.07, 0.07), 0.2)

	curr_coords = coords



func _get_cards_distribution():
	line_layoyt._get_collider_corner(collision_shape)
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = line_layoyt.distribute_points_with_max_distance(current_card_count, collision_shape)
	return coords
	
