extends SuperCard

func attackTarget(target: SuperCard, state: StatesNode2D.States = states.States.FIRST_STRIKE) -> void:
	target.recieveAttack(attackNode, state, self)

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	healthNode.depleteHealth(enemyAttack.getAttack(), enemy, enemyState)
