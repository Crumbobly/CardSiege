extends Control

@export var game = preload("res://scenes/game/3d/Game.tscn")
@onready var ping_lbl = $Panel/VBoxContainer/PingBtn/PingLbl


func _ready() -> void:
	Server.request_handler.register_scene("Lobby", self)
	
	
func set_ping_lbl(request_time):
	var whole_ping = round((Time.get_unix_time_from_system() - request_time) * 1000)
	ping_lbl.text = str(whole_ping) + " ms"

	
func _on_ping_btn_pressed() -> void:
	var request = Request.new("Server", "ping", ["Lobby", "set_ping_lbl", Time.get_unix_time_from_system()])
	Server.send_request(request)
	

func _on_online_game_btn_pressed() -> void:
	var request = Request.new("Lobby", "add_queue", [])
	Server.send_request(request)


func start_online_game(my_id, game_dict: Dictionary):
	var game_instance: Game = game.instantiate()
	get_tree().root.get_node("Root").change_scene(game_instance)
	game_instance.set_data(my_id, game_dict)
		

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
