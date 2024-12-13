extends CanvasLayer

var showed = false

func show_settings():
	if showed:
		$ShowSettingsAnim.play("hide")
		showed = false
	else:
		$ShowSettingsAnim.play("show")
		showed = true


func _on_my_btn_2_pressed() -> void:
	$Panel/VBoxContainer/Center/MarginContainer/PageWrapper/Pages/AnimationPlayer.play("SwapPages")
