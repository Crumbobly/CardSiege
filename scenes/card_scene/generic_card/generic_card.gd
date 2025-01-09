extends Node2D
class_name GenericCard

@export_group("Image")
@export var mainImage : Resource = preload("res://assets/images/card/squire.jpg")

@export_group("Margin")
@export var img_left_margin : int = 42
@export var img_top_margin : int = 96
@export var img_right_margin : int = 44
@export var img_bottom_margin : int = 56

@export_group("Labels")
@export var attack : int = 0
@export var health : int = 0
@export var nameStr : String = "Generic"
@export_multiline var description : String = ""

@export_group("Nodes")
@export var imgTextureRect : TextureRect
@export var imgMarginContainer : MarginContainer
@export var nameLabel : Label
@export var atkLabel : Label
@export var hpLabel : Label
@export var descRichTextLabel : RichTextLabel
@export var healthNode : HealthNode2D
@export var attackNode : AttackNode2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthNode.healthChanged.connect(_on_health_changed)
	attackNode.attackChanged.connect(_on_attack_changed)
	
	imgTextureRect.texture = mainImage
	
	imgMarginContainer.add_theme_constant_override("margin_left", img_left_margin)
	imgMarginContainer.add_theme_constant_override("margin_top", img_top_margin)
	imgMarginContainer.add_theme_constant_override("margin_right", img_right_margin)
	imgMarginContainer.add_theme_constant_override("margin_bottom", img_bottom_margin)
	
	healthNode.setAbsoluteHealth(health)
	attackNode.setAbsoluteAttack(attack)
	
	nameLabel.text = nameStr
	
	descRichTextLabel.text = description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_health_changed(changeAmount: int, curentHealth: int, attacker: Node2D, state: StatesNode2D.States) -> void:
	hpLabel.text = str(curentHealth)

func _on_attack_changed(changeAmount: int, curentAttack: int) -> void:
	atkLabel.text = str(curentAttack)

func getHealthNode() -> HealthNode2D:
	return healthNode

func getAttackNode() -> AttackNode2D:
	return attackNode
