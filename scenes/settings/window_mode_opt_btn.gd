extends OptionButton


const WINDOW_MODE_ARRAY = [
	"Windowed",
	"Fullscreen",
]

func _ready() -> void:
	add_window_mode_items()
	self.set_item()
	self.item_selected.connect(change_window_mode)


func add_window_mode_items():
	for window_mode in WINDOW_MODE_ARRAY:
		self.add_item(window_mode)


func set_item():
	var mode = ProjectSettings.get_setting("display/window/size/mode")
	match mode:
		0:
			self.select(0)
		4: 
			self.select(1)
		_:
			self.select(1)


func change_window_mode(index: int) -> void:
	
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			ProjectSettings.set_setting("display/window/size/mode", 0) 
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)		
			ProjectSettings.set_setting("display/window/size/mode", 4) 

	ProjectSettings.save()
