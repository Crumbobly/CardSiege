extends Object
class_name ResourcesData

var money: int = 0
var material: int = 0
var mana: int = 0

func _init(res_obj) -> void:
	self.money = res_obj["money"]
	self.material = res_obj["material"]
	self.mana = res_obj["mana"]
