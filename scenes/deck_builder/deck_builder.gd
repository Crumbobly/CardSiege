extends Node2D

@export_group("Max Number of Cards")
@export var maxNumberOfCards: int = 40

@export_group("Item List Nodes")
@export var addItemList : ItemList
@export var countItemList : ItemList

@export_group("Button Nodes")
@export var exitBtn : Button
@export var optionsBtn : Button
@export var backBtn : Button
@export var saveBtn : Button

var lobby_scene: PackedScene

var itemArray: Array[int]
var totalSum: int

func changeCounter(index: int, change: int) -> void:
	var newCount : int = int(countItemList.get_item_text(index)) + change
	countItemList.set_item_text(index, str(newCount))

func incrementCounter(index: int) -> void:
	changeCounter(index, 1)
	
func decrementCounter(index: int) -> void:
	changeCounter(index, -1)

func changeTotalSum(index: int, change: int) -> void:
	totalSum += change
	itemArray[index] += change
	
func incrementTotalSum(index: int) -> void:
	changeTotalSum(index, 1)

func decrementTotalSum(index: int) -> void:
	changeTotalSum(index, -1)

func addToDeck(index: int) -> void:
	if totalSum == maxNumberOfCards: return
	incrementTotalSum(index)
	incrementCounter(index)

func removeFromDeck(index: int) -> void:
	if int(countItemList.get_item_text(index)) == 0: return
	decrementTotalSum(index)
	decrementCounter(index)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	totalSum = DeckLoader.unloadDeck(countItemList, itemArray)
	itemArray = Global.loadedCards.duplicate()
	
	addItemList.item_selected.connect(_on_right_item_selected)
	countItemList.item_selected.connect(_on_left_item_selected)
	
	exitBtn.pressed.connect(_on_exit_btn_pressed)
	optionsBtn.pressed.connect(_on_settings_btn_pressed)
	backBtn.pressed.connect(_on_back_btn_pressed)
	saveBtn.pressed.connect(_on_save_btn_pressed)
	
	lobby_scene = load("res://scenes/lobby/2d_lobby.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_settings_btn_pressed() -> void:
	Settings2d.show_settings()

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
	
func _on_back_btn_pressed() -> void:
	get_tree().change_scene_to_packed(lobby_scene)

func _on_save_btn_pressed() -> void:
	Global.saveDeck(itemArray)

func _on_right_item_selected(index: int) -> void:
	addToDeck(index)

func _on_left_item_selected(index: int) -> void:
	removeFromDeck(index)
