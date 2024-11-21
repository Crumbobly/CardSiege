extends OptionButton

@onready var settings = $"../../../.."

const BASE_RESOLUTION_DICT = {
	"1280x720": Vector2i(1280, 720),        # HD
	"1360x768": Vector2i(1360, 768),
	"1366x768": Vector2i(1366, 768),        # WXGA (широкоформатное HD)
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600, 900),        # HD+
	"1920x1080": Vector2i(1920, 1080),      # Full HD
	"2560x1080": Vector2i(2560, 1080),      # Ultrawide HD
	"2560x1440": Vector2i(2560, 1440),      # 2K QHD
	"3440x1440": Vector2i(3440, 1440),      # Ultrawide QHD
	"3840x2160": Vector2i(3840, 2160),      # 4K UHD
}

var CURR_RESOLUTION_DICT


func _set_resolution_list():
	var new_list = {}
	for res in BASE_RESOLUTION_DICT:
		if BASE_RESOLUTION_DICT[res] <= settings.display_resolution:
			new_list[res] = BASE_RESOLUTION_DICT[res]
	return new_list


func _ready() -> void:
	CURR_RESOLUTION_DICT = _set_resolution_list()
	add_resolution_items()
	set_preselected_item()
	self.item_selected.connect(change_resolution)


func set_preselected_item():
	var res_list = CURR_RESOLUTION_DICT.values()
	for i in range(len(res_list) - 1, -1, -1):
		if res_list[i] <= settings.curr_res:
			self.select(i)
			return


func add_resolution_items():
	for res in CURR_RESOLUTION_DICT:
		self.add_item(res)


func change_resolution(index: int) -> void:
	var resolution = CURR_RESOLUTION_DICT.values()[index]

	ProjectSettings.set_setting("display/window/size/viewport_width", resolution.x)
	ProjectSettings.set_setting("display/window/size/viewport_height", resolution.y)
	ProjectSettings.save()

	# waiting restart
