extends Node3D
class_name CardLayout

@export var hand_cards: Node3D # Узел, куда будут помещаться карты

var hand_line = LineLayoutLogic.new()
var card_collection: Array[Card3D] = []  # Коллекция карт
var selected_card: Card3D = null  # Выбранная в данный момент карта
var selected_card_z: float = 0  # Смещение по z выбранной карты
var card_count: int = 0  # Кол-во карт в руке (перетаскиваемая в данный момент карта считается)


func _ready():
	hand_cards = Node3D.new()
	hand_cards.name = "Cards"
	add_child(hand_cards)



func _get_cards_distribution():
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = hand_line.distribute_points_with_max_distance(current_card_count)
	return coords


func recalculate_all_card_position(coords):
	
	if coords == null:
		return
		
	for index in range(len(card_collection)):
		card_collection[index].position.z = (index + 1) * 0.001
		print(card_collection[index].global_position)
		print(card_collection[index].rotation)

func add_card(new_card3d: Card3D):
	
	new_card3d.mouse_entered.connect(card_selected)
	new_card3d.mouse_exited.connect(card_unselected)
	
	hand_cards.add_child(new_card3d)
	
	card_collection.append(new_card3d)
	new_card3d.set_card_name(str(card_count))
	card_count += 1
	
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)


func remove_card(card: Card3D):
	
	card.mouse_entered.disconnect(card_selected)
	card.mouse_exited.disconnect(card_unselected)
	card.mouse_exited.emit()
	
	card_collection.erase(card)
	hand_cards.remove_child(card)
	card_count -= 1
	
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)
	
	
func card_selected(card: Card3D):
	# При перетаскивании карты она selected пока не будет отпущена игроком. Значит мы не можем сделать новой select
	if selected_card and selected_card.is_drag:
		return
		
	selected_card_z = card.position.z  
	card.position.z = 0.1  # Выносим карту на передний план
	selected_card = card  # переопределяем selected_card
	card_highlight(card)


func card_unselected(card: Card3D):
	# При перетаскивании карты она selected пока не будет отпущена игроком. Значит мы не можем сделать unselect
	if selected_card and selected_card.is_drag:
		return
	
	
	card.position.z = selected_card_z  # Возвращаем карту на своё место в руке (по оси Z)
	selected_card_z = 0 
	card_unhighlight(card)
	selected_card = null
		
	# Располагаем карты по определённому порядку
	var coords = _get_cards_distribution()
	recalculate_all_card_position(coords)


func card_highlight(card: Card3D):
	card.hi()
	

func card_unhighlight(card: Card3D):
	card.unhi()
