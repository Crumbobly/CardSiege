extends Control

var reg_log_switch: bool = true
var login_string: String
var password_string: String
var timer_end: bool = false

var lobby_scene: PackedScene = preload("res://scenes/lobby/lobby.tscn")
var no_connection_scene: PackedScene = preload("res://scenes/auth/NoConnection.tscn")
	
@onready var timer: Timer = $Timer
@onready var login_field = $Control/MarginContainer/VBoxContainer/HBoxContainer/LoginField
@onready var password_field = $Control/MarginContainer/VBoxContainer/HBoxContainer2/PasswordField
@onready var error_lbl = $Control/MarginContainer/VBoxContainer/BoxContainer/ErrorLbl


func _ready() -> void:
	Server.request_handler.register_scene("Auth", self)
	timer.timeout.connect(timeout)


func set_error_lbl_text(msg: String):
	error_lbl.text = msg
	timer.stop()
	

func _on_log_reg_switch_btn_pressed() -> void:
	reg_log_switch = !reg_log_switch
	

func _on_login_field_text_changed() -> void:
	error_lbl.text = ""
	login_string = login_field.text


func _on_password_field_text_changed() -> void:
	error_lbl.text = ""
	password_string = password_field.text


func timeout():
	server_not_here()
	timer_end = true
	

func server_here(my_login: String):

	if timer_end:
		return

	timer.stop()
	get_tree().root.get_node("Root").change_scene(lobby_scene.instantiate())
	

func server_not_here():

	if timer_end:
		return
		
	timer.stop()
	get_tree().root.get_node("Root").change_scene(no_connection_scene.instantiate())


func _on_auth_btn_pressed() -> void:

	timer_end = false
	error_lbl.text = ""
	timer.set_wait_time(10)
	timer.start()
	
	var password_hash = password_string.sha1_text()
	var request_func = "login" if reg_log_switch else "register"
	var request = Request.new(\
		"Auth", \
		request_func, \
		[login_string, password_hash]\
	)
	Server.send_request(request)
	
	
func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_settings_btn_pressed() -> void:
	get_tree().root.get_node("Root").show_settings()
