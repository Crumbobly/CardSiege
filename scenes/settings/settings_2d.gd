extends Control

var display_resolution = DisplayServer.screen_get_size()
var curr_res_x = ProjectSettings.get_setting("display/window/size/viewport_width")
var curr_res_y = ProjectSettings.get_setting("display/window/size/viewport_height")
var curr_res = Vector2i(curr_res_x, curr_res_y)
var curr_mode_index = _set_curr_mode_index()


func _set_curr_mode_index():
	var mode = ProjectSettings.get_setting("display/window/size/mode")
	match mode:
		0: return 0
		4: return 1
	

func _on_resolution_opt_btn_item_selected(index: int) -> void:
	$Control/VBox/Control/MarginContainer/VBoxContainer/RestartLbl.visible = true
