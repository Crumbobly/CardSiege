extends Node3D


@onready var hand = $Hand

func _on_button_pressed() -> void:
	hand.add_card()
