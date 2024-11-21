class_name FakeHand 
extends CardLayout

var hand_radius = 1.5
var hand_circle = CircleLayoutLogic.new(hand_radius)  # Класс круга "руки"


func _get_cards_distribution():
	
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = hand_circle.distribute_points_with_max_distance(current_card_count)
	return coords


func recalculate_all_card_position(coords):
	
	if coords == null:
		return
		
	super.recalculate_all_card_position(coords)	
	
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		var card_pos = hand_circle.get_card_position(coords[index]) # Определяем координаты карты на "круге" руки
		
		card.pos_in_hand_y = card_pos[1]  # Записываем в карту её исходную позицию на oY в руке.
		card.set_anim_pos(card_pos[0], card_pos[1])  # Перемещаем карту на нужные координаты
		var angle = Vector3(0, 0, -card_pos[2])  # Вектор наклона карты в руке
		card.set_anim_rotation_degrees(angle)
		card.angle_in_hand = angle
		card.height_offset = hand_circle.circle_radius - card_pos[1]
		
	
func add_card(new_card3d: Card3D):
	super.add_card(new_card3d)
	
	new_card3d.card_id = Global.RANDOM.generate_id()
	new_card3d.set_card_name(str(new_card3d.card_id))


func remove_card(card: Card3D):
	super.remove_card(card)


func card_highlight(card: Card3D):
	super.card_highlight(card)
	

func card_unhighlight(card: Card3D):
	super.card_unhighlight(card)
