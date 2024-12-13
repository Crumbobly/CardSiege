extends Control

# Загрузка сцены лобби
var lobby_scene: PackedScene = preload("res://scenes/lobby/2d_lobby.tscn")

# Флаги для состояния
var is_login: bool = true
var timer_end: bool = true

# Узлы интерфейса
@onready var timer: Timer = $Timer
@onready var load_gif_anim: LoadGifControl = $Control/MarginContainer/MarginContainer/VBoxContainer/LoadGifControl

@onready var auth_btn: MyBtn = $Control/MarginContainer/MarginContainer/VBoxContainer/BtnBox/AuthBtn
@onready var login_box: GridContainer = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/LoginBox
@onready var auth_box: VBoxContainer = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox
@onready var reg_box: GridContainer = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/RegBox
@onready var log_reg_switch: LinkButton = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/LogRegLbl

@onready var login_login_field: MyLineEdit = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/LoginBox/LoginField
@onready var login_password_field: MyLineEdit = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/LoginBox/PasswordField

@onready var reg_login_field: MyLineEdit = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/RegBox/LoginField
@onready var reg1_password_field: MyLineEdit = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/RegBox/PasswordField
@onready var reg2_password_field: MyLineEdit = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/RegBox/RepeatPasswordField

@onready var error_lbl: Label = $Control/MarginContainer/MarginContainer/VBoxContainer/AuthBox/ErrorLbl


# Инициализация
func _ready() -> void:
	Server.request_handler.register_scene("Auth", self)
	timer.timeout.connect(timeout)


# Устанавливает текст ошибки
func set_error_lbl_text(msg: String) -> void:
	error_lbl.text = msg
	timer.stop()
	timer_end = true


func enable_all_line_edit_field():
	reg_login_field.enable_line_edit()
	reg1_password_field.enable_line_edit()
	reg2_password_field.enable_line_edit()
	login_login_field.enable_line_edit()
	login_password_field.enable_line_edit()
	

func disable_all_line_edit_field():
	reg_login_field.disable_line_edit()
	reg1_password_field.disable_line_edit()
	reg2_password_field.disable_line_edit()
	login_login_field.disable_line_edit()
	login_password_field.disable_line_edit()
	
	
# Обрабатывает нажатие кнопки авторизации
func _on_auth_btn_pressed() -> void:
	if not timer_end:
		return
		
	reset_errors()
	start_timer(2)

	if is_login:
		login()
	else:
		register()


# Логика входа
func login() -> void:
	
	# Первичная валидация данных
	if not login_login_field.validate() or not login_password_field.validate():
		set_error_lbl_text("Login and password can only contain Latin letters and numbers")
		return
	
	# Создание запроса
	var request = Request.new("Auth", "login", [
		login_login_field.get_text(),
		login_password_field.get_text().sha1_text()
	])
	
	# Выключение редактирования полей и отправка запроса на сервер
	disable_all_line_edit_field()
	Server.send_request(request)


# Логика регистрации
func register() -> void:
	
	# Первичная валидация данных
	if not reg_login_field.validate() or \
	   not reg1_password_field.validate() or \
	   not reg2_password_field.validate():
		set_error_lbl_text("Login and password can only contain Latin letters and numbers")
		return

	if reg1_password_field.get_text() != reg2_password_field.get_text():
		set_error_lbl_text("Passwords don't match")
		return
	
	# Создание запроса
	var request = Request.new("Auth", "register", [
		reg_login_field.get_text(),
		reg1_password_field.get_text().sha1_text()
	])
	
	# Выключение редактирования полей и отправка запроса на сервер
	disable_all_line_edit_field()
	Server.send_request(request)


# Обрабатывает переключение между входом и регистрацией
func _on_log_reg_lbl_pressed() -> void:
	reset_errors()
	
	login_box.visible = !login_box.visible
	reg_box.visible = !reg_box.visible
	is_login = login_box.visible
	
	log_reg_switch.text = "No account?" if is_login else "Have account?"
	auth_btn.set_text("Login" if is_login else "Register")


# Сбрасывает текст ошибки
func reset_errors() -> void:
	error_lbl.text = ""


# Запускает таймер
func start_timer(timeout_seconds: float) -> void:
	timer_end = false
	timer.set_wait_time(timeout_seconds)
	timer.start()


# Таймаут ответа сервера
func timeout() -> void:
	enable_all_line_edit_field()
	server_not_here()
	timer_end = true


# Сервер доступен
func server_here(my_login: String) -> void:
	timer.stop()
	get_tree().change_scene_to_packed(lobby_scene)


# Сервер недоступен
func server_not_here() -> void:
	timer.stop()
	error_lbl.text = "No server connection"


# Выход из игры
func _on_exit_btn_pressed() -> void:
	get_tree().quit()


# Переход в настройки
func _on_settings_btn_pressed() -> void:
	Settings2d.show_settings()
