extends Control

# Загрузка сцены лобби
var lobby_scene: PackedScene = preload("res://scenes/lobby/2d_lobby.tscn")

# Флаги для состояния
var is_login: bool = true
var timer_end: bool = true

# Узлы интерфейса
@onready var timer: Timer = $Timer
@onready var auth_btn = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/AuthBtn
@onready var login_box = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/LoginBox
@onready var reg_box = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/RegBox
@onready var log_reg_switch = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/LogRegLbl

@onready var login_login_field = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/LoginBox/HBoxContainer/LoginField
@onready var login_password_field = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/LoginBox/HBoxContainer2/PasswordField

@onready var reg_login_field = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/RegBox/HBoxContainer/LoginField
@onready var reg1_password_field = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/RegBox/HBoxContainer2/PasswordField
@onready var reg2_password_field = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/RegBox/HBoxContainer3/RepeatPasswordField

@onready var error_lbl = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/ErrorLbl
@onready var no_conn_lbl = $Control/MarginContainer/MarginContainer/VBoxContainer/VBoxContainer/NoConnLbl


# Инициализация
func _ready() -> void:
	Server.request_handler.register_scene("Auth", self)
	timer.timeout.connect(timeout)


# Устанавливает текст ошибки
func set_error_lbl_text(msg: String) -> void:
	error_lbl.text = msg
	timer.stop()


func switch_editable_field(editable: bool):
	reg_login_field.editable = editable
	reg1_password_field.editable = editable
	reg2_password_field.editable = editable
	login_login_field.editable = editable
	login_password_field.editable = editable
	
	
# Обрабатывает нажатие кнопки авторизации
func _on_auth_btn_pressed() -> void:
	if not timer_end:
		return
		
	switch_editable_field(false)
	reset_errors()
	start_timer(2)  # Запуск таймера ожидания ответа

	if is_login:
		login()
	else:
		register()


# Логика входа
func login() -> void:
	if not login_login_field.validate() or not login_password_field.validate():
		set_error_lbl_text("Login and password can only contain Latin letters and numbers")
		return

	var request = Request.new("Auth", "login", [
		login_login_field.text,
		login_password_field.text.sha1_text()
	])
	print("log")
	Server.send_request(request)


# Логика регистрации
func register() -> void:
	print("reg")
	if not reg_login_field.validate() or \
	   not reg1_password_field.validate() or \
	   not reg2_password_field.validate():
		set_error_lbl_text("Login and password can only contain Latin letters and numbers")
		return

	if reg1_password_field.text != reg2_password_field.text:
		set_error_lbl_text("Passwords don't match")
		return

	var request = Request.new("Auth", "register", [
		reg_login_field.text,
		reg1_password_field.text.sha1_text()
	])
	Server.send_request(request)


# Обрабатывает переключение между входом и регистрацией
func _on_log_reg_lbl_pressed() -> void:
	reset_errors()
	login_box.visible = !login_box.visible
	reg_box.visible = !reg_box.visible

	is_login = login_box.visible
	log_reg_switch.text = "No account?" if is_login else "Have account?"
	auth_btn.text = "Login" if is_login else "Register"


# Сбрасывает ошибки и сообщения
func reset_errors() -> void:
	error_lbl.text = ""
	no_conn_lbl.visible = false


# Запускает таймер
func start_timer(timeout_seconds: float) -> void:
	timer_end = false
	timer.set_wait_time(timeout_seconds)
	timer.start()


# Таймаут ответа сервера
func timeout() -> void:
	switch_editable_field(true)
	server_not_here()
	timer_end = true


# Сервер доступен
func server_here(my_login: String) -> void:
	timer.stop()
	get_tree().change_scene_to_packed(lobby_scene)


# Сервер недоступен
func server_not_here() -> void:
	timer.stop()
	no_conn_lbl.visible = true


# Выход из игры
func _on_exit_btn_pressed() -> void:
	get_tree().quit()


# Переход в настройки
func _on_settings_btn_pressed() -> void:
	get_node("SettingsCanvas").show_settings()
