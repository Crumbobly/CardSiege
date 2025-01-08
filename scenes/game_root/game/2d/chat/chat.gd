extends Control

@export var chat_block_scene = preload("res://scenes/game_root/game/2d/chat/chat_block.tscn")
@onready var offset =  $Panel/HBoxContainer/MarginContainer.size[0]
@onready var message_box = $Panel/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MessageBox
@onready var container = $Panel/HBoxContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
var showed = false
var start_pos_x


func _ready() -> void:
	var color_rect = $Panel/ColorRect
	var box = $Panel/HBoxContainer/MarginContainer
	var old_heght = color_rect.size[1]
	color_rect.set_size(Vector2(box.size[0], old_heght))
	
	self.global_position.x -= offset
	start_pos_x = self.global_position.x
	
	Server.request_handler.register_scene("GameChat", self)
	

func add_message(nick: String, msg: String):
	var chat_block: ChatBlock = chat_block_scene.instantiate()
	chat_block.set_message(msg)
	chat_block.set_nickname(nick)
	container.add_child(chat_block)


func move():
	var tween = create_tween().set_ease(Tween.EASE_IN)
	if !showed:
		tween.tween_property(self, "global_position:x", start_pos_x + offset, 0.2)
		showed = true
	else:
		tween.tween_property(self, "global_position:x", start_pos_x, 0.2)
		showed = false
	

func _on_button_2_pressed() -> void:
	move()


func _on_send_message_btn_pressed() -> void:
	var parent_game3d: Game = $"../../../../.."
	var enemy_id = parent_game3d.game_logic.enemy_id
	var msg = message_box.text
	
	var request = Request.new("GameChat", "write_in_chat", [enemy_id, msg])
	Server.send_request(request)
	message_box.text = ""
