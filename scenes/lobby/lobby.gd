extends Node3D

@export var game = preload("res://scenes/game/Game.tscn")
var textbox: TextEdit
var chat: RichTextLabel


func _ready() -> void:
	textbox = $"2D/SubViewportContainer/SubViewport/DelText"
	chat = $"2D/SubViewportContainer/SubViewport/DelChat"
	NetworkManager.register_scene("Lobby", self)
	
	
func _on_online_game_btn_pressed() -> void:
	get_tree().change_scene_to_packed(game)


func _on_del_write_pressed() -> void:
	if(textbox.text == ""):
		pass
	else:
		var request = Request.new("Server", "client_chat_callback", [multiplayer.get_unique_id(), textbox.text])
		Server.rpc_on_server(request)
		textbox.clear()


func write_in_chat(msg):
	chat.text += "\n" + msg


func set_ping(request_time):
	var whole_ping = round((Time.get_unix_time_from_system() - request_time) * 1000)
	$"2D/SubViewportContainer/SubViewport/PingLbl".text = str(whole_ping) + " ms"


func _on_ping_btn_pressed() -> void:
	var callback_class = "Lobby"
	var callback_func = "set_ping"
	Server.ping(callback_class, callback_func)
	
