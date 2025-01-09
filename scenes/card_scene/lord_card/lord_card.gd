extends SuperCard

var armorNode : ArmorNode2D

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	armorNode = $ArmorNode2D
	var damage : int = enemyAttack.mitigateAttack(armorNode.getArmor())
	healthNode.depleteHealth(damage, enemy, enemyState)
