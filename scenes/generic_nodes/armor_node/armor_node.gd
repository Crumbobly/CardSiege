extends Node2D
class_name ArmorNode2D

@export var armor : int = 1

func setArmor(armor: int) -> void:
	self.armor = armor

func getArmor() -> int:
	return armor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
