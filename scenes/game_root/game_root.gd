extends Node3D


@onready var game = $Game


func set_data(my_id: String, game_dict: Dictionary):
	game.set_data(my_id, game_dict)
