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
		Server.send_message_to_server(textbox.text)
		textbox.clear()
	

func write_in_chat(msg):
	chat.text += "\n" + msg
	
