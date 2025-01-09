extends Node2D
class_name AttackNode2D

@export var baseAttack : int = 0
var curentAttack : int

signal attackChanged(changeAmount: int, curentAttack: int)

func changeAttack(changeAmount: int) -> void:
	curentAttack += changeAmount
	attackChanged.emit(changeAmount, curentAttack)

func depleteAttack(amountToDeplete: int) -> void:
	amountToDeplete = abs(amountToDeplete)
	changeAttack(-amountToDeplete)

func addAttack(amountToAdd: int) -> void:
	amountToAdd = abs(amountToAdd)
	changeAttack(amountToAdd)

func setAttack(attack: int) -> void:
	if attack > baseAttack: attack = baseAttack
	changeAttack(attack - curentAttack)
	
func setBaseAttack(baseAttack: int) -> void:
	self.baseAttack = baseAttack
	
func setAbsoluteAttack(absAttack: int) -> void:
	setBaseAttack(absAttack)
	setAttack(absAttack)
	
func mitigateAttack(mitigation: int) -> int:
	var res : int = curentAttack - mitigation
	if res < 0 : res = 0
	return res
	
func getAttack() -> int:
	return curentAttack
	
func getBaseAttack() -> int:
	return baseAttack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curentAttack = baseAttack

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
