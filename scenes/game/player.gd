extends Node3D

@onready var our_hand = $Hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	our_hand.hand_identity = Identity.Identity.PLAYER


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
