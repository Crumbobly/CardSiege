extends Control
class_name ChatBlock

var message_text: String = ""
var nickname_text: String = ""

func set_message(text: String):
	message_text = text
	$VBoxContainer/TextLbl.text = message_text

func set_nickname(nick: String):
	nickname_text = nick
	$VBoxContainer/LoginLbl.text = nickname_text
	
func _ready():
	$VBoxContainer/TextLbl.text = message_text
	$VBoxContainer/LoginLbl.text = nickname_text
	var parent = self.get_parent_area_size()
	self.custom_minimum_size[0] = parent[0]
