extends Object
class_name Request

var scene_class_name: String
var func_name: String
var args: Array = []


func _init(scene_class_name: String, func_name: String, args: Array) -> void:
	self.scene_class_name = scene_class_name
	self.func_name = func_name
	self.args = args


func to_dict() -> Dictionary:
	return {
		"scene_class_name": scene_class_name,
		"func_name": func_name,
		"args": args
		}

	
static func from_dict(data: Dictionary) -> Request:

	var scene_class_name = data.get("scene_class_name", "")
	var func_name = data.get("func_name", "")
	var args = data.get("args", [])

	var request = Request.new(scene_class_name, func_name, args)
	return request
