extends Control
class_name MyBtn

@export var init_text = "Text"
@onready var lbl: RichTextLabel = $Label


signal pressed

func _ready() -> void:
	set_text(init_text)
	reset_line()


func set_text(new_text):
	lbl.text = new_text
	var font = lbl.get_theme_font("normal_font")
	var text_size = font.get_string_size(new_text)
	lbl.size = text_size 
	reset_line()


func reset_line():

	var rect_size = lbl.size
	var line = $Label/Line2D
	line.clear_points()
		
	var point1 = Vector2(
		0,
		rect_size[1] / 1.2
	)
		
	var point2 = Vector2(
		rect_size[0],
		rect_size[1] / 1.2
	)
	
	line.add_point(point1)
	line.add_point(point2)
	line.default_color = Color(1,1,1,0)


func _on_label_mouse_entered() -> void:
	$AnimationPlayer.play("show_sprites")


func _on_label_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("show_sprites")


func light():
	$AnimationPlayer2.play("clicked")


func unlight():
	$AnimationPlayer2.play_backwards("clicked")


func _on_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:  
			pressed.emit()
			get_viewport().gui_release_focus()
			light()
	
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:  
			unlight()
		   
