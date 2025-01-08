extends CanvasLayer


@onready var pages = $Panel/VBoxContainer/Center/MarginContainer/PageWrapper/Pages
var showed = false


func show_settings():
	if showed:
		$ShowSettingsAnim.play("hide")
		pages.return_to_main_page_anim()
		showed = false
	else:
		$ShowSettingsAnim.play("show")
		showed = true


func _on_exit_settings_button_pressed() -> void:
	show_settings()

func _on_exit_game_btn_pressed() -> void:
	get_tree().quit()
