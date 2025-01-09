extends Node2D
class_name HealthNode2D

@export var maxHealth : int = 0
var curentHealth : int
var states : StatesNode2D = StatesNode2D.new()

signal healthChanged(changeAmount: int, curentHealth: int, attacker: Node2D, state: StatesNode2D.States)
signal healthDroped(dropAmount: int, curentHealth: int, attacker: Node2D, state: StatesNode2D.States)

func changeHealth(changeAmount: int, attacker: Node2D, state: StatesNode2D.States) -> void:
	curentHealth += changeAmount
	healthChanged.emit(changeAmount, curentHealth, attacker, state)
	if changeAmount < 0: 
		healthDroped.emit(changeAmount, curentHealth, attacker, state)

func depleteHealth(amountToDeplete: int, attacker: Node2D, state: StatesNode2D.States) -> void:
	amountToDeplete = abs(amountToDeplete)
	changeHealth(-amountToDeplete, attacker, state)

func addHealth(amountToAdd: int) -> void:
	amountToAdd = abs(amountToAdd)
	changeHealth(amountToAdd, null, states.States.UTIL)

func setHealth(health: int) -> void:
	if health > maxHealth: health = maxHealth
	changeHealth(health - curentHealth, null, states.States.UTIL)
	
func setMaxHealth(maxHealth: int) -> void:
	self.maxHealth = maxHealth
	
func setAbsoluteHealth(absHealth: int) -> void:
	setMaxHealth(absHealth)
	setHealth(absHealth)
	
func getHealth() -> int:
	return curentHealth
	
func getMaxHealth() -> int:
	return maxHealth
	
func isDead() -> bool:
	return curentHealth <= 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curentHealth = maxHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
