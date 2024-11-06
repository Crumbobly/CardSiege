extends Node2D

var reg_log_switch: bool = true
var login_string: String
var password_string: String
var timer_end: bool = false

@onready var timer: Timer = $Timer
@onready var login_field = $LoginField
@onready var password_field = $PasswordField
@onready var error_lbl = $ErrorLbl


func _ready() -> void:
	DisplayServer.window_set_title("Вход")
	Server.request_handler.register_scene("Auth", self)
	Server.join_server()

	error_lbl.visible = false
	timer.timeout.connect(timeout)


func _on_log_reg_check_btn_button_up() -> void:
	reg_log_switch = false


func _on_login_field_text_changed() -> void:
	hide_error()
	login_string = login_field.text


func _on_password_field_text_changed() -> void:
	hide_error()
	password_string = password_field.text


func _on_auth_btn_pressed() -> void:
	timer_end = false
	timer.set_wait_time(10)
	timer.start()
	
	var request_func = "login" if reg_log_switch else "register"
	var request = Request.new(\
		"Auth", \
		request_func, \
		[multiplayer.get_unique_id(), login_string, password_string]\
	)
	Server.rpc_on_server(request)


func show_error():
	timer.stop()
	error_lbl.visible = true


func hide_error():
	error_lbl.visible = false


func timeout():
	server_not_here()
	timer_end = true
	

func server_here(my_login: String):

	if timer_end:
		return

	timer.stop()
	var scene: PackedScene = load("res://scenes/lobby/lobby.tscn")
	get_tree().change_scene_to_packed(scene)
	DisplayServer.window_set_title(my_login)
	

func server_not_here():

	if timer_end:
		return
		
	timer.stop()
	var scene: PackedScene = load("res://scenes/auth/NoConnection.tscn")
	get_tree().change_scene_to_packed(scene)
