extends CardLayout
class_name Field

var circle_layut = CircleLayoutLogic.new(11.5)
var line_layoyt = LineLayoutLogic.new()


func recalculate_all_card_position(coords):
	
	if coords == null:
		return
		
	super.recalculate_all_card_position(coords)	
	
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		card.position.x = coords[index]
		card.global_position.y = self.position.y


func _get_cards_distribution():
	var current_card_count = len(card_collection)
	if current_card_count == 0:
		return null
	
	# Определение точек на отезке
	var coords = circle_layut.distribute_points_with_max_distance(current_card_count)
	return coords
	
	
	
