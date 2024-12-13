extends Control
class_name MyLineEdit

@export_group("Custom Font Properties")
@export var custom_font_size = 32
@export_enum(
	"NotoSans", 
	"Gesture",
	"Optimus",
	"Platin") \
	var custom_font: String

@export_group("Line Edit Properties")
@export var secret: bool = false
@export var regex_pattern: String = r"^[a-zA-Z0-9]+$" 
@export var max_lenght: int = 0
@export var icon_visible: bool = false

@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var btn: Button = $HBoxContainer/Button
var has_error: bool = false


func get_text():
	return self.line_edit.text


func disable_line_edit():
	self.line_edit.editable = false


func enable_line_edit():
	self.line_edit.editable = true
	

func _ready() -> void:
	self.set_size_by_resolution()
	self.size = self.line_edit.size
	self.icon_init()
	self.line_edit.secret = secret
	self.line_edit.max_length = max_lenght
	self.line_init()
	set_font()


func set_font():
	line_edit.add_theme_font_override("font", FontManager.get_font(custom_font))
	line_edit.add_theme_font_size_override("font_size", FontManager.recalulate_size(custom_font_size))


func icon_init():
	if not self.icon_visible:
		self.btn.self_modulate = Color(0,0,0,0)
		self.btn.disabled = true
	
	
func line_init():
	var line: Line2D = $HBoxContainer/LineEdit/Line2D
	line.clear_points()
	var point1 = Vector2(0,line_edit.size[1] )
	var point2 = Vector2(line_edit.size[0],line_edit.size[1])
	line.add_point(point1)
	line.add_point(point2)


func validate() -> bool:
	var regex = RegEx.new()
	regex.compile(regex_pattern)
	if regex.search(line_edit.text) == null:
		return false
	if line_edit.text == "":
		return false
	if len(line_edit.text) > line_edit.max_length and line_edit.max_length != 0:
		return false
	return true


func set_size_by_resolution():
	var resilution = get_viewport().size
	if resilution[0] <= 1280:
		self.size[1] = 30
	elif resilution[0] <= 1600:
		self.size[1] = 40
	else:
		self.size[1] = 50


func _on_line_edit_focus_entered() -> void:
	if !self.has_error:
		$AnimationPlayer.play("line_change_color")


func _on_line_edit_focus_exited() -> void:
	if !self.has_error:
		$AnimationPlayer.play_backwards("line_change_color")


func _on_line_edit_text_changed(new_text: String) -> void:
	if !validate():
		if !self.has_error:
			self.has_error = true
			$AnimationPlayer.play("error")
	else:
		if self.has_error:
			self.has_error = false
			$AnimationPlayer.play_backwards("error")


func _on_line_edit_text_change_rejected(rejected_substring: String) -> void:
	$AnimationPlayer.play("warning")


func _on_line_edit_resized() -> void:
	if line_edit:
		line_init()
