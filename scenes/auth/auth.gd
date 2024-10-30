extends Node2D

var is_login: bool = true
var login: String
var password: String
@onready var timer: Timer = $Timer
var timer_end: bool = false

@onready var login_field = $LoginField
@onready var password_field = $PasswordField


func _ready() -> void:
	$Unsec.visible = false
	$UnsecLog.visible = false
	timer.timeout.connect(timeout)
	Server.join_server()
	NetworkManager.register_scene("Auth", self)

func _on_log_reg_check_btn_button_up() -> void:
	is_login = false
	$Unsec.visible = false
	$UnsecLog.visible = false

func _on_login_field_text_changed() -> void:
	login = login_field.text

func _on_password_field_text_changed() -> void:
	password = password_field.text

func _on_auth_btn_pressed() -> void:
	timer_end = false
	timer.set_wait_time(10)
	timer.start()
	Server.auth(login, password, is_login)

func uncorrect_data(type):
	if(type == 0):
		$UnsecLog.visible = true
	else:
		$UnsecLog.visible = false
	if(type == 1):
		$Unsec.visible = true
	else:
		$Unsec.visible = false
func timeout():
	server_not_here()
	timer_end = true
	
func server_here():

	if timer_end:
		return

	timer.stop()
	var scene: PackedScene = load("res://scenes/lobby/lobby.tscn")
	get_tree().change_scene_to_packed(scene)

func server_not_here():

	if timer_end:
		return
		
	timer.stop()
	var scene: PackedScene = load("res://scenes/auth/NoConnection.tscn")
	get_tree().change_scene_to_packed(scene)
