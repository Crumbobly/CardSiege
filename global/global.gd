extends Node

@export var CAMERA: Camera = null
@export var CARD_PREVIEW: CardPreview = null
@export var RANDOM: Random = Random.new()

func _input(event: InputEvent) -> void:

	if Input.is_action_just_pressed("open_settings"):
		#if get_viewport().gui_get_focus_owner():
			#get_viewport().gui_release_focus()
			#return
		Settings2d.show_settings()
