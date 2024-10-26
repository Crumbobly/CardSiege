extends Node3D

@onready var card3d_scene: PackedScene = preload("res://scenes/card3d/Card3D.tscn") #  Запакованная сцена карты
@onready var PlayerHand = $Player/Hand
@onready var EnemyHand =  $Enemy/EnemyHand
@export var cards_count_start : int = 5
@onready var player_fields = $FieldPlayer
@onready var enemy_fields = $FieldEnemy
 
var hand_to_add : Hand
var retime = false

enum game_states {
	PLAYER_TURN,
	ENEMY_TURN	
}

func _process(delta: float) -> void:
	print($Timer.time_left)

func _ready() -> void:
	$Timer.start()
	await get_tree().create_timer(1.0).timeout
	hand_to_add = PlayerHand
	player_fields.set_hand(PlayerHand)
	enemy_fields.set_hand(EnemyHand)	
	for i in range(cards_count_start):
		PlayerHand.is_from_dic = true
		EnemyHand.is_from_dic = true
		EnemyHand.add_card(card3d_scene.instantiate())
		PlayerHand.add_card(card3d_scene.instantiate())


func _on_button_pressed() -> void:
	hand_to_add.is_from_dic = true
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

func retimer():
	$Timer.start()
	if(retime == false):
		_on_check_button_toggled(true)
		retime = true
		return
	if(retime == true):
		_on_check_button_toggled(false)
		retime = false
		return	
	
func _on_timer_timeout() -> void:
	retimer()


func _on_switch_button_pressed() -> void:
	$Timer.stop()
	if(retime == false):
		_on_check_button_toggled(true)
		$Timer.start()
		retime = true
		return
	if(retime == true):
		_on_check_button_toggled(false)
		$Timer.start()
		retime = false
		return
