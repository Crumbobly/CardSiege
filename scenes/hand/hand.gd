class_name Hand
extends Node3D

@onready var hand_cards = $Cards  # Место под карты в руке
@onready var hand_circle = $HandCircle  # Класс круга "руки"
@onready var card3d_scene: PackedScene = preload("res://scenes/Card3D/Card3D.tscn") #  Запакованная сцена карты

@export var card_collection: Array[Card3D] = []  # Коллекция карт
@export var selected_card: Card3D = null  # Выбранная в данный момент карта
var selected_card_z: float = 0  # Смещение по z выбранной карты
@export var card_count: int = 0  # Кол-во карт в руке (перетаскиваемая в данный момент карта считается)


func dragged_card(card: Card3D):
	var thead = Thread.new()
	thead.start(_card_follow)


func _card_follow():
	while selected_card != null and selected_card.is_drag:
		var pos: Vector3 = Global.CAMERA.get_look_cords()
		selected_card.follow(pos)
		await get_tree().create_timer(0.01).timeout
		

func dropped_card(card: Card3D):
	if selected_card:
		var selected_card_index = card_collection.find(selected_card)
		var coords = hand_circle.move_apart(card_count, selected_card_index)
		recalculate_all_card_position(coords)
	
	else:
		var coords = _get_cards_distribution()
		recalculate_all_card_position(coords)


func _get_cards_distribution():
	
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	return coords


# Получение координат на которые нужно вернуть карту
# y - позиция карты в руке 
# Example: Мы навели курсор на карту, она стала hightlight, затем мы её перетащили и отпустили.
# :В этом случае карту нужно будет вернуть на ту высоту, на которой она была как hightlight карта.
# :Затем она сама сделается unhighlight и опуститься.
func recalculate_coords_for_return_card(card: Card3D, y):
	if card.is_highlight:
		return y + card.hightlight_height + card.height_offset
	return y


func recalculate_all_card_position(coords):
	
	if coords == null:
		return
		
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		var card_pos = hand_circle.get_card_position(coords[index]) # Определяем координаты карты на "круге" руки
		
		card.pos_in_hand_y = card_pos[1]  # Записываем в карту её исходную позицию на oY в руке.
		var hightlight_pos_offset = recalculate_coords_for_return_card(card, card_pos[1])  # Пересчитываем позицию карты на oY, исходя из данных о том, была ли текущая карта hightlight
		card.set_anim_pos(card_pos[0], hightlight_pos_offset)  # Перемещаем карту на нужные координаты

		var angle = Vector3(0, 0, -card_pos[2])  # Вектор наклона карты в руке
		
		# Если текущая карта selected, то мы не будем менять её наклон
		if card != selected_card:
			card.set_anim_rotation_degrees(angle)
			
		card.angle_in_hand = angle
		card.height_offset = hand_circle.circle.shape.radius - card_pos[1]
	
	
func add_card():

	var new_card3d = card3d_scene.instantiate()
	new_card3d.position.z = card_count * 0.001  # Нужно чтобы карты "накладывалсь" друг на друга
	
	new_card3d.dragging.connect(dragged_card)
	
	new_card3d.mouse_entered.connect(card_selected)
	new_card3d.mouse_exited.connect(card_unselected)
	
	new_card3d.mouse_entered.connect(card_highlight)
	new_card3d.mouse_exited.connect(card_unhighlight)
	
	new_card3d.dropped.connect(dropped_card)
	
	hand_cards.add_child(new_card3d)
	card_collection.append(new_card3d)
	new_card3d.set_card_name(str(card_count))
	card_count += 1
	
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
	
func card_selected(card: Card3D):
	# При перетаскивании карты она selected пока не будет отпущена игроком. Значит мы не можем сделать новой select
	if selected_card and selected_card.is_drag:
		return
	
	selected_card_z = card.position.z  
	card.position.z = 0.1  # Выносим карту на передний план
	selected_card = card  # переопределяем selected_card
	
	# Располагаем карты по определённому порядку
	var selected_card_index = card_collection.find(selected_card)
	var coords = hand_circle.move_apart(card_count, selected_card_index)
	recalculate_all_card_position(coords)


func card_unselected(card: Card3D):
	# При перетаскивании карты она selected пока не будет отпущена игроком. Значит мы не можем сделать unselect
	if selected_card and selected_card.is_drag:
		return
	
	card.position.z = selected_card_z  # Возвращаем карту на своё место в руке (по оси Z)
	selected_card_z = 0 
	selected_card = null
	
	# Располагаем карты по определённому порядку
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)


func card_highlight(card: Card3D):
	card.highlight()


func card_unhighlight(card: Card3D):
	card.unhighlight()
