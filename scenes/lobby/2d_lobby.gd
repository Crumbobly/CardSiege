extends Node2D

@export var game = preload("res://scenes/game/Game.tscn")

func _ready() -> void:
	Server.request_handler.register_scene("Lobby", self)
	
	
func set_ping(request_time):
	var whole_ping = round((Time.get_unix_time_from_system() - request_time) * 1000)
	$PingLbl.text = str(whole_ping) + " ms"

	
func _on_ping_btn_pressed() -> void:
	var callback_class = "Lobby"
	var callback_func = "set_ping"
	Server.ping(callback_class, callback_func)


func _on_online_game_btn_pressed() -> void:
	var request = Request.new("Lobby", "add_waiting_player", [multiplayer.get_unique_id()])
	Server.rpc_on_server(request)


func start_online_game(enemy_id):
	var game_instance: Game = game.instantiate()

	# Добавляем сцену игры.
	get_tree().root.add_child(game_instance)
	game_instance.set_enemy_id(enemy_id)
	
	# Удаляем сцену текущую сцену - лобби
	for scene in get_tree().root.get_children():
		if scene is Lobby:
			get_tree().root.remove_child(scene)
			break
			
