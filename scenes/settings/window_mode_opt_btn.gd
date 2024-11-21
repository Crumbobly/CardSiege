extends OptionButton

@onready var settings = $"../../../.."

const WINDOW_MODE_ARRAY = [
	"Оконный режим",
	"Полноэрканный режим",
]

func _ready() -> void:
	add_window_mode_items()
	set_preselected_item()
	self.item_selected.connect(change_window_mode)


func set_preselected_item():
	self.select(settings.curr_mode_index)


func add_window_mode_items():
	for window_mode in WINDOW_MODE_ARRAY:
		self.add_item(window_mode)


func change_window_mode(index: int) -> void:
	
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			get_window().size = settings.curr_res
			ProjectSettings.set_setting("display/window/size/mode", 0) 
		
		1: 
			DisplayServer.window_set_size(settings.display_resolution)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)		
			ProjectSettings.set_setting("display/window/size/mode", 4) 

			
	ProjectSettings.save()
