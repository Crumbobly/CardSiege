extends Object
class_name CardData

var name: String

func _init(card_obj: Dictionary) -> void:
	self.name = card_obj["name"]
