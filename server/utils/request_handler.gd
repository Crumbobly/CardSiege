extends Object
class_name RequestHandler

var scene_references = {}

func register_scene(scene_name: String, scene_ref: Node) -> void:
	scene_references[scene_name] = scene_ref

func handle_request(request: Request):
	
	var scene_name = request.scene_class_name
	var function_name = request.func_name
	var args = request.args

	if scene_references.has(scene_name):
		var scene: Node = scene_references[scene_name]
		if scene.has_method(function_name):
			scene.callv(function_name, args)
		else:
			assert(false, "Функция " + function_name + " не найдена в сцене " + scene_name)
	else:
		assert(false, "Сцена " + scene_name + " не зарегистрирована")
	
