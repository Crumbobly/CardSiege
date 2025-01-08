extends CanvasLayer
class_name YesNoMenu

@onready var label = $Control/MarginContainer/VBoxContainer/Label
signal accept
signal reject


func set_text(text):
	label.text = text


func _on_yes_btn_pressed() -> void:
	accept.emit()
	queue_free()


func _on_no_btn_pressed() -> void:
	reject.emit()
	queue_free()
	

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		queue_free()
