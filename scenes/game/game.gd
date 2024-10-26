extends Node3D

@onready var card3d_scene: PackedScene = preload("res://scenes/card3d/Card3D.tscn") #  Запакованная сцена карты
@onready var PlayerHand = $Player/Hand
@onready var EnemyHand =  $Enemy/EnemyHand
@export var cards_count_start : int = 5
@onready var player_fields = $FieldPlayer
@onready var enemy_fields = $FieldEnemy
 
var hand_to_add : Hand

func _ready() -> void:
	hand_to_add = PlayerHand
	player_fields.set_hand(PlayerHand)
	enemy_fields.set_hand(EnemyHand)	
	for i in range(cards_count_start):
		EnemyHand.add_card(card3d_scene.instantiate())
		PlayerHand.add_card(card3d_scene.instantiate())


func _on_button_pressed() -> void:
	hand_to_add.add_card(card3d_scene.instantiate())


func _on_button_2_pressed() -> void:
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		hand_to_add = EnemyHand
		player_fields._set_identity(1)
		enemy_fields._set_identity(0)
		PlayerHand._set_identity(1)
		EnemyHand._set_identity(0)
	else :
		hand_to_add = PlayerHand
		player_fields._set_identity(0)
		enemy_fields._set_identity(1)
		PlayerHand._set_identity(0)
		EnemyHand._set_identity(1)
