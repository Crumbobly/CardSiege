extends Node3D
class_name Game

@onready var card3d_scene: PackedScene = preload("res://scenes/card3d/Card3D.tscn") #  Запакованная сцена карты
@onready var hand = $Hand
@onready var game_2d = $"2D/SubViewportContainer/SubViewport/Game2D"
@export var enemy_id: int


func _ready() -> void:
	Server.request_handler.register_scene("Game", self)


func set_enemy_id(id):
	enemy_id = id
	game_2d.enemy_id = id
	

func _on_button_pressed() -> void:
	hand.add_card(card3d_scene.instantiate())
