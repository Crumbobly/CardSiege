extends Object
class_name GameData

var chat: Array
var my_id: String
var enemy_id: String
var my_login: String
var enemy_login: String
var my_hp: int
var enemy_hp: int
var my_library_size: int
var enemy_library_size: int
var my_hand: Array[CardData]
var my_hand_size: int
var enemy_hand_size: int
var my_resources: ResourcesData
var enemy_resources: ResourcesData

var enemy_row_long: Array[CardData]
var enemy_row_middle: Array[CardData]
var enemy_row_near: Array[CardData]
var my_row_near: Array[CardData]
var my_row_middle: Array[CardData]
var my_row_long: Array[CardData]


func _init(my_id: String, game_obj: Dictionary) -> void:
	self.chat = game_obj["chat"]
	self.my_id = my_id
	
	var my_index
	var enemy_index
	if game_obj["player1_id"] == my_id:
		my_index = 1
		enemy_index = 2
	else:
		my_index = 2
		enemy_index = 1
	
	self.enemy_id = game_obj["player%d_id" % enemy_index]
	self.my_login = game_obj["player%d_login" % my_index]
	self.enemy_login = game_obj["player%d_login" % enemy_index]
	self.my_hp = game_obj["hp%d" % my_index]
	self.enemy_hp = game_obj["hp%d" % enemy_index]
	self.my_library_size = game_obj["library%d_size" % my_index]
	self.enemy_library_size = game_obj["library%d_size" % enemy_index]
	self.my_hand_size = game_obj["hand%d_size" % my_index]
	self.enemy_hand_size = game_obj["hand%d_size" % enemy_index]
	self.my_resources = ResourcesData.new(game_obj["resources%d" % my_index])
	self.enemy_resources = ResourcesData.new(game_obj["resources%d" % enemy_index])
	
	self.my_hand = []
	for obj in game_obj["hand%d" % my_index]:
		self.my_hand.append(CardData.new(obj))
	
	self.enemy_row_long = []
	for i in game_obj["field"]["row%d_long" % enemy_index]:
		self.enemy_row_long.append(CardData.new(i))
		
	self.enemy_row_middle = []
	for i in game_obj["field"]["row%d_middle" % enemy_index]:
		self.enemy_row_middle.append(CardData.new(i))
	
	self.enemy_row_near = []
	for i in game_obj["field"]["row%d_near" % enemy_index]:
		self.enemy_row_near.append(CardData.new(i))
	
	self.my_row_near = []
	for i in game_obj["field"]["row%d_near" % my_index]:
		self.my_row_near.append(CardData.new(i))
		
	self.my_row_middle = []
	for i in game_obj["field"]["row%d_middle" % my_index]:
		self.my_row_middle.append(CardData.new(i))
	
	self.my_row_long = []
	for i in game_obj["field"]["row%d_long" % my_index]:
		self.my_row_long.append(CardData.new(i))
		
