extends Node3D
class_name Game

@onready var hand = $Hand
@onready var fake_hand = $FakeHand
@onready var game_2d: Game2D = $"2D/Game2D/SubViewport/Game2D"
var game_logic: GameData = null


func set_data(my_id: String, game_dict: Dictionary):
	self.game_logic = GameData.new(my_id, game_dict)
