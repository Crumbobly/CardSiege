extends Node2D
class_name Game2D

var showed = false
var enemy_id: int
var enemy_login: String

@onready var start_pos_x = self.global_position.x
@onready var message_box = $Chat/MessageBox
@onready var chat = $Chat
@onready var chat_lbl = $Chat/ChatLbl
@onready var enemy_name_lbl = $EnemyIs/Node2D/EnemyNameLbl
@onready var enemy_is_animation = $EnemyIs/AnimationPlayer


func _ready() -> void:
	Server.request_handler.register_scene("Game2D", self)
	

func move():
	var tween = create_tween().set_ease(Tween.EASE_IN)
	if !showed:
		tween.tween_property(chat, "global_position:x", start_pos_x + 800, 0.2)
		showed = true
	else:
		tween.tween_property(chat, "global_position:x", start_pos_x, 0.2)
		showed = false
	

func _on_button_2_pressed() -> void:
	move()

	
func anim_who_is_enemy(enemy_login: String):
	enemy_name_lbl.text += enemy_login
	enemy_is_animation.play("EnemyIsAnimation")
	enemy_name_lbl.text + ""
	
	
func print_msg(login: String, msg: String):
	chat_lbl.text += login + ": " + msg + "\n"


func _on_send_message_btn_pressed() -> void:
	var msg = message_box.text
	var request = Request.new("Game", "write_in_chat", [enemy_id, msg])
	Server.rpc_on_server(request)
	# TODO("Sync")
	print_msg("Вы", msg)
	message_box.text = ""
