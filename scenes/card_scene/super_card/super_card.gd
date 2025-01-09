extends Node2D
class_name SuperCard

var healthNode : HealthNode2D
var attackNode : AttackNode2D
var states : StatesNode2D
var attackMitigation : int = 0

func abandonTheShip() -> void:
	if healthNode.isDead():
		get_tree().free()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var card : GenericCard = $GenericCard
	healthNode = card.getHealthNode()
	attackNode = card.getAttackNode()
	states = $StatesNode2D
	
	healthNode.healthDroped.connect(_on_health_droped)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attackTarget(target: SuperCard, state: StatesNode2D.States = states.States.ATTACK) -> void:
	#target.healthNode.depleteHealth(attackNode.getAttack(), self, state)
	target.recieveAttack(attackNode, state, self)

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	push_error("recieveAttack() function is yet to be realized")

func _on_health_droped(dropAmount: int, curentHealth: int, attacker: SuperCard, state: StatesNode2D.States) -> void:
	if state == states.States.DEFEND: 
		abandonTheShip()
	if state == states.States.ATTACK:
		attackTarget(attacker, states.States.DEFEND)
		abandonTheShip()
	if state == states.States.FIRST_STRIKE:
		abandonTheShip()
		attackTarget(attacker, states.States.DEFEND)
	if state == states.States.LONG_ATTACK:
		abandonTheShip()
	if state == states.States.UTIL:
		pass
