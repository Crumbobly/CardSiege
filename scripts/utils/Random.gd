extends Resource
class_name Random

var existing_ids = [] 
const char_pool = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
var current_lenght = 5


static func generate_random_string(lenght : int) -> String:
	var result = ""
	for i in lenght:
		result += char_pool[randi() % char_pool.length()]
	return result


func generate_id() -> String:
	randomize()
	while true:		
		var new_id = generate_random_string(current_lenght)
		if new_id not in existing_ids:
			existing_ids.append(new_id)
			return new_id
		if len(existing_ids) >= pow(char_pool.length(), current_lenght):
			current_lenght +=1
	return ""
