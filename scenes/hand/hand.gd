class_name Hand extends Node2D

@onready var hand_cards = $Cards
@onready var hand_circle = $HandCircle
@onready var card1: PackedScene = preload("res://scenes/card/Card.tscn")

@export var card_collection: Array[Card] = []
@export var selected_index_card_collection: Array[int] = []
@export var selected_card : Card = null
var del = 0


func _process(delta: float) -> void:

	if selected_card != null and selected_card.is_drag:
		selected_card.global_position = get_global_mouse_position()
		
	

func dropped_card(card: Card):	
	
	card.unhighlight()
	############
	print("dropped_card")

	card.is_highlight_moved = false
	recalculate_all_card_position()
	

"""
Функция пересчета (переустановки) позиций карт в руке
set_scale - заменить на глобальную переменную или ...
"""
func _get_cards_positions():
	
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек 
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	return coords


func recalculate_all_card_position():
	var coords = _get_cards_positions()
	
	if coords == null:
		return
		
	for i in range(len(coords)):
		recalculate_one_card_position(i, coords)


func recalculate_one_card_position(i: int, coords, only_pos: bool = false):
	var card = card_collection[i]
	var card_pos = hand_circle.get_card_position(coords[i])
	card.position.x = card_pos[0]
	card.position.y = card_pos[1]
	if !only_pos:
		card.set_rotation_degrees(card_pos[2])
	card.height_offset = hand_circle.circle.shape.radius + card_pos[1]


func add_card():
	var new_card = card1.instantiate()
	new_card.card_name = str(del)
	del += 1
	new_card.mouse_entered.connect(card_selected)
	new_card.mouse_exited.connect(card_unselected)
	new_card.dropped.connect(dropped_card)
	
	card_collection.append(new_card)
	hand_cards.add_child(new_card)
	recalculate_all_card_position()


"""Пока удаляет последнюю карту"""
func remove_card():
	var removed_card = card_collection.pop_back()
	hand_cards.remove_child(removed_card)
	recalculate_all_card_position()


func card_selected(card: Card):
	var card_index = card_collection.find(card)
	selected_index_card_collection.append(card_index)
	recalculate_highlight_cards()


func card_unselected(card: Card):
	print("card_unselected")
	var card_index = card_collection.find(card)
	selected_index_card_collection.remove_at(selected_index_card_collection.find(card_index))
	recalculate_highlight_cards()


# TODO("Переписать")
func recalculate_highlight_cards():
	
	if selected_card and selected_card.is_drag:
		return
	
	var max_card_index = selected_index_card_collection.max()
	var max_card 
	
	if max_card_index == null:
		max_card = null
	else:
		max_card = card_collection[max_card_index]
	selected_card = max_card
	
	for index in range(len(card_collection)):
		
		if index == max_card_index:
			if max_card.is_highlight == false:
				max_card.highlight()
				hand_cards.move_child(max_card, -1)
				
		else:
			var other_card = card_collection[index]
			other_card.is_drag = false
			other_card.was_drag = false
			
			if other_card.is_highlight == true:
				other_card.unhighlight()
				
			var old_index = card_collection.find(other_card)
			if max_card_index != null and old_index < max_card_index:
				hand_cards.move_child(other_card, old_index)
			elif max_card_index != null and old_index > max_card_index:
				hand_cards.move_child(other_card, old_index - 1)
			if max_card_index == null:
				hand_cards.move_child(other_card, index)


func _on_button_pressed() -> void:
	add_card()


func _on_del_card_btn_pressed() -> void:
	remove_card()
