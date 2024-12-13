extends Control
class_name MyBtn

@export var init_text = "Text"
@export_group("Custom Font Properties")
@export var custom_font_size = 32
@export_enum(
	"NotoSans", 
	"Gesture",
	"Optimus",
	"Platin") \
	var custom_font: String

@onready var lbl: RichTextLabel = $Label
@onready var left_sprite: Sprite2D = $LeftSprite
@onready var right_sprite: Sprite2D = $RightSprite

signal pressed


func _ready() -> void:
	set_font()
	set_text(init_text)
	reset_sprites_positions()
	reset_line()
	# self.size[0] += left_sprite.get_rect().size[0] * left_scale_factor[0] * 2


func set_font():
	lbl.add_theme_font_override("normal_font", FontManager.get_font(custom_font))
	lbl.add_theme_font_size_override("normal_font_size", FontManager.recalulate_size(custom_font_size))
	reset_sprites_positions()
	reset_line()


func set_text(new_text):
	lbl.text = new_text
	var font = lbl.get_theme_font("normal_font")
	var text_size = font.get_string_size(new_text)
	lbl.size = text_size 
	reset_sprites_positions()
	reset_line()


func reset_sprites_positions():
	var lbl_width = lbl.size[0]
	var lbl_height = lbl.size[1]
	
	var left_scale_factor = Vector2(lbl_height, lbl_height) / left_sprite.texture.get_size()
	left_sprite.scale = left_scale_factor / 1.2
	left_sprite.position = lbl.position
	left_sprite.position.y += lbl_height / 2
	left_sprite.position.x -= left_sprite.texture.get_size()[0] * left_scale_factor[0] / 2
	
	var right_scale_factor = Vector2(lbl_height, lbl_height) / right_sprite.texture.get_size()
	right_sprite.scale = right_scale_factor / 1.2
	right_sprite.position = lbl.position
	right_sprite.position.y += lbl_height / 2
	right_sprite.position.x += lbl_width + \
		right_sprite.texture.get_size()[0] * right_scale_factor[0] / 2


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
		   
