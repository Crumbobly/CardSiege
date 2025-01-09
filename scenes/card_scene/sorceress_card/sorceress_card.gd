extends SuperCard

func attackTarget(target: SuperCard, state: StatesNode2D.States = states.States.LONG_ATTACK) -> void:
	target.recieveAttack(attackNode, state, self)

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	healthNode.depleteHealth(enemyAttack.getAttack(), enemy, enemyState)

func _on_health_droped(dropAmount: int, curentHealth: int, attacker: SuperCard, state: StatesNode2D.States) -> void:
	abandonTheShip()
