class_name Hand extends Node3D

@onready var hand_cards = $Cards
@onready var hand_circle = $HandCircle
@onready var card3d_scene: PackedScene = preload("res://scenes/Card3D/Card3D.tscn")

@export var card_collection: Array[Card3D] = []
@export var selected_card: Card3D = null
var selected_card_z: float = 0
@export var card_count: int = 0


func _process(delta: float) -> void:

	if selected_card != null and selected_card.is_drag:
		var pos: Vector3 = Global.CAMERA.get_look_cords()
		selected_card.global_position.x = pos[0]
		selected_card.global_position.y = pos[1]
		
	
func dropped_card(card: Card3D):	
	card.anim_set_pos_x(card.last_pos[0])
	card.anim_set_pos_y(card.last_pos[1])



func _get_cards_distribution():
	
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	return coords


func recalculate_all_card_position(coords, rotate=true, pos=true):

	if coords == null:
		return
		
	for index in range(len(coords)):
		var card = card_collection[index]
		var card_pos = hand_circle.get_card_position(coords[index])
		
		if pos:
			card.anim_set_pos_x(card_pos[0])
			card.anim_set_pos_y(card_pos[1])
		card.pos_in_hand = [card_pos[0], card_pos[1]]
		
		var angle = Vector3(0, 0, -card_pos[2])
		card.angle_in_hand = angle
		if rotate:
			card.set_anim_rotation_degrees(angle)
			
			
		card.height_offset = hand_circle.circle.shape.radius - card_pos[1]


	
func add_card():

	var new_card3d = card3d_scene.instantiate()
	new_card3d.position.z = card_count * 0.001
	new_card3d.mouse_entered.connect(card_selected)
	new_card3d.mouse_exited.connect(card_unselected)
	new_card3d.dropped.connect(dropped_card)
	
	hand_cards.add_child(new_card3d)
	card_collection.append(new_card3d)
	new_card3d.set_card_name(str(card_count))
	card_count += 1
	
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
	
func card_selected(card: Card3D):
	if selected_card and selected_card.is_drag:
		var selected_card_index = card_collection.find(selected_card)
		var coords = hand_circle.move_apart(card_count, selected_card_index)
		recalculate_all_card_position(coords, true, false)
		return
		
	selected_card_z = card.position.z
	card.position.z = 0.1
	selected_card = card
	
	var selected_card_index = card_collection.find(selected_card)
	var coords = hand_circle.move_apart(card_count, selected_card_index)
	recalculate_all_card_position(coords)
	
	card.highlight()

func card_unselected(card: Card3D):
	if selected_card and selected_card.is_drag:
		return
		
	card.unhighlight()
	card.position.z = selected_card_z
	# if selected_card == card:
	selected_card_z = 0
	selected_card = null
	#
	
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
