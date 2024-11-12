extends Node3D
class_name Game

@onready var card3d_scene: PackedScene = preload("res://scenes/card3d/Card3D.tscn") #  Запакованная сцена карты
@onready var hand = $Hand
@onready var fake_hand = $FakeHand
@onready var game_2d: Game2D = $"2D/SubViewportContainer/SubViewport/Game2D"
var enemy_id: int
var enemy_login: String

# TODO( начинаем заниматься сценой игры)
# По идее при загрузке сцены нам достаточно знать id соперника (его мы уже знаем) 
# 	и логины обоих игроков (для визуала).
#
# Все отсальные данные (руки и т.д.) будут загружены с сервера позже 
# 	(например после выбора "первоходящего" игрока)
# Полученные таким образом данные будут загружены через специальные функции.


func _ready() -> void:
	Server.request_handler.register_scene("Game", self)


func set_enemy(enemy_id, enemy_login):
	self.enemy_id = enemy_id
	self.enemy_login = enemy_login
	game_2d.enemy_id = enemy_id
	game_2d.enemy_login = enemy_login
	game_2d.anim_who_is_enemy(enemy_login)
	

func _on_button_pressed() -> void:
	hand.add_card(card3d_scene.instantiate())


func _on_button_2_pressed() -> void:
	fake_hand.add_card(card3d_scene.instantiate())
