class_name DeckLoader

static var cardDict: Dictionary = {
	0:"squire",
	1:"knight",
	2:"black_knight",
	3:"lord",
	4:"monk",
	5:"sorceress"
}

static func loadDeck(cardsToLoad: Array[int]) -> void:
	Global.cardDeck = []
	var curentCard : String
	var resStr : String
	
	for i in range(0, cardsToLoad.size()):
		curentCard = cardDict[i]
		for j in range(0, cardsToLoad[i]):
			resStr = "res://scenes/card_scene/%s_card/%s_card.tscn" % [curentCard, curentCard]
			Global.cardDeck.append(load(resStr))

static func unloadDeck(countItemList: ItemList, itemArray: Array[int]) -> int:
	var sum : int = 0
	itemArray = Global.loadedCards.duplicate()
	for i in range(0, itemArray.size()):
		countItemList.set_item_text(i, str(itemArray[i]))
		sum += itemArray[i]
	return sum
