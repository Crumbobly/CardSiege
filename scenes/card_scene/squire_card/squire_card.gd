extends SuperCard

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	healthNode.depleteHealth(enemyAttack.getAttack(), enemy, enemyState)
