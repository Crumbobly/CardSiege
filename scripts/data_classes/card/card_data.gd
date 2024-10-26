class_name CardData extends Resource

@export var name: String
@export var cost_resource_list: CostResourceList
@export var flavor_text: String

var database : Dictionary = {
	"FIRST" : {
		"id" : "0001",
		"hp" : 1,
		"damage" : 1,
		"description" : "Простая 1/1 карта"
	},
	"SECOND" : {
		"id" : "0002",
		"hp" : 2,
		"damage" : 2,
		"description" : "Простая 2/2 карта"
	},
	"THIRD" : {
		"id" : "0003",
		"hp" : 1,
		"damage" : 0,
		"description" : "0"
	}
}

var card_type = Type.NULL
var hp : int

enum Type {
	CREATURE,
	NULL,
	
}

func set_hp(_hp : int):
	if card_type == Type.CREATURE :
		hp = _hp
		
func set_card_type(type : int):
	if(type == 0):
		card_type = Type.CREATURE
