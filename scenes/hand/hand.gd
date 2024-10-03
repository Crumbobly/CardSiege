class_name Hand extends Node2D

@onready var hand_cards = $Cards
@onready var hand_circle = $HandCircle
@onready var card1: PackedScene = preload("res://scenes/card/Card.tscn")

@export var card_collection: Array[Card] = []
@export var selected_index_card_collection: Array[int] = []
@export var selected_card : Card = null
var del = 0

var start_pos
var is_drag = false 
var on_table = false


func _get_card_pos():
	var card_imdex = card_collection.find(selected_card)
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	var card_pos = hand_circle.get_card_position(coords[card_imdex])
	selected_card.set_position(Vector2(card_pos[0], card_pos[1]))
	selected_card.set_rotation_degrees(card_pos[2])
	selected_card.height_offset = hand_circle.circle.shape.radius + card_pos[1]
	selected_card.set_scale(Vector2(0.4, 0.4))



"""
Функция пересчета (переустановки) позиций карт в руке
set_scale - заменить на глобальную переменную или ...
"""
func recalculate_cards_positions():
	
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return
	
	# Определение точек 
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	
	# Установка карты в каждую точку и поворот карты на необходимый угол
	for i in range(len(coords)):
		var card = card_collection[i]
		var card_pos = hand_circle.get_card_position(coords[i])
		card.set_position(Vector2(card_pos[0], card_pos[1]))
		card.set_rotation_degrees(card_pos[2])
		card.height_offset = hand_circle.circle.shape.radius + card_pos[1]
		card.set_scale(Vector2(0.4, 0.4))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_drag = true
			else :
				is_drag = false

func _process(delta: float) -> void:

	print_debug(start_pos)
	if is_drag and selected_card != null:
		selected_card.global_position = get_global_mouse_position()
	if !is_drag and !on_table and selected_card != null:
		_get_card_pos()

func add_card():
	var new_card = card1.instantiate()
	new_card.card_name = str(del)
	del += 1
	new_card.mouse_entered.connect(card_selected)
	new_card.mouse_exited.connect(card_unselected)
	card_collection.append(new_card)
	hand_cards.add_child(new_card)
	recalculate_cards_positions()
	
	
"""Пока удаляет последнюю карту"""
func remove_card():
	var removed_card = card_collection.pop_back()
	hand_cards.remove_child(removed_card)
	recalculate_cards_positions()



func card_selected(card: Card):
	var card_index = card_collection.find(card)
	selected_card = card
	selected_index_card_collection.append(card_index)
	recalculate_highlight_cards()
	

	
	
func card_unselected(card: Card):
	var card_index = card_collection.find(card)
	selected_card = null
	selected_index_card_collection.remove_at(selected_index_card_collection.find(card_index))
	recalculate_highlight_cards()


# TODO("Переписать")
func recalculate_highlight_cards():
	var max_card_index = selected_index_card_collection.max()
	
	for index in range(len(card_collection)):
		if index == max_card_index:
			var max_card = card_collection[max_card_index]
			if max_card.is_highlight == false:
				max_card.highlight()
				hand_cards.move_child(max_card, -1)
		else:
			var other_card = card_collection[index]
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
