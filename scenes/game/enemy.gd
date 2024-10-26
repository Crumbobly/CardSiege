extends Node3D

@onready var _hand = $EnemyHand
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hand.hand_identity = Identity.Identity.ENEMY


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
