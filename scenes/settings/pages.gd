extends Control

@onready var main_page = $MainPage
@onready var gameplay_page = $GameplayPage
@onready var graphic_page = $GraphicPage
@onready var audio_page = $AudioPage
@onready var anim_player = $AnimationPlayer


func get_current_page():
	if main_page.visible:
		return 0
	if gameplay_page.visible:
		return 1
	if graphic_page.visible:
		return 2
	if audio_page.visible:
		return 3

func return_to_main_page_anim():
	var curr_page_index = get_current_page()
	match curr_page_index:
		1:
			anim_player.play_backwards("GameplayPageAnim")
		2:
			anim_player.play_backwards("GraphicPageAnim")
		3:
			anim_player.play_backwards("AudioPageAnim")
		_:
			pass

func _on_gameplay_btn_pressed() -> void:
	anim_player.play("GameplayPageAnim")


func _on_graphic_btn_pressed() -> void:
	anim_player.play("GraphicPageAnim")


func _on_audio_btn_pressed() -> void:
	anim_player.play("AudioPageAnim")


func _on_return_to_main_page_settings_btn_pressed() -> void:
	return_to_main_page_anim()
