extends Area3D

signal card_entered(card)
signal card_exited(card)


func _on_area_entered(area: Area3D) -> void:
	var parent = area.get_parent_node_3d()
	if parent is Card3D:
		print("Card entered the field area: ", parent.name)
		emit_signal("card_entered", parent)


func _on_area_exited(area: Area3D) -> void:
	var parent = area.get_parent_node_3d()
	if parent is Card3D:
		print("Card exited the field area: ", parent.name)
		emit_signal("card_exited", parent)
