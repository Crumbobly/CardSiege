extends Node3D


@onready var hand = $Hand

func _on_button_pressed() -> void:
	hand.add_card()


func _on_button_2_pressed() -> void:
	hand.remove_card()
