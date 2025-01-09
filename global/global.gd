extends Node

@export var CAMERA: Camera = null
#@export var CARD_PREVIEW: CardPreview = null
@export var RANDOM: Random = Random.new()

var cardDeck: Array[PackedScene]
var loadedCards: Array[int] = [16, 8, 4, 1, 6, 5]

func saveDeck(newLoadedCards: Array[int]) -> void:
	loadedCards = newLoadedCards.duplicate()
	DeckLoader.loadDeck(newLoadedCards)

func _ready() -> void:
	DeckLoader.loadDeck(loadedCards)

func _unhandled_input(event: InputEvent) -> void:

	if Input.is_key_pressed(KEY_ESCAPE):
		#if get_viewport().gui_get_focus_owner():
			#get_viewport().gui_release_focus()
			#return
		Settings2d.show_settings()
