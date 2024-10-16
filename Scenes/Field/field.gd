extends CardLayout
class_name Field

func recalculate_all_card_position(coords):
	
	if coords == null:
		return
		
	super.recalculate_all_card_position(coords)	
	
	for index in range(len(coords)):
		var card: Card3D = card_collection[index]
		card.position.x = coords[index]
		card.global_position.y = self.position.y
