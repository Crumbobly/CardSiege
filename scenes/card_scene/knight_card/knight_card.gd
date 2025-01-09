extends SuperCard

var armorNode : ArmorNode2D

func recieveAttack(enemyAttack: AttackNode2D, enemyState: StatesNode2D.States, enemy: SuperCard) -> void:
	armorNode = $ArmorNode2D
	var damage : int
	if enemy.is_in_group("sorceress"):
		damage = enemyAttack.mitigateAttack(armorNode.getArmor())
	else:
		damage = enemyAttack.getAttack()
	healthNode.depleteHealth(damage, enemy, enemyState)
