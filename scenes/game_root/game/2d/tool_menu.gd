extends Control

@onready var card3d_scene: PackedScene = preload("res://scenes/card3d/Card3D.tscn") #  Запакованная сцена карты
@onready var hand = $"../../../../Hand"
@onready var fake_hand = $"../../../../FakeHand"


func _on_button_pressed() -> void:
	hand.add_card(card3d_scene.instantiate())


func _on_button_2_pressed() -> void:
	fake_hand.add_card(card3d_scene.instantiate())
