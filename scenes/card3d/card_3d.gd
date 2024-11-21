class_name Card3D extends Node3D

@onready var card_name_lbl = $CardNameLbl
@onready var raycast: RayCast3D = $RayCast3D


var is_highlight: bool = false  # подсвечена ли карта 
var is_drag = false  # перетаскивается ли карта


# animation properties
var my_tween_list: MyTweenList = MyTweenList.new() # Список активных твинов. Нужен для оставноки всех активных анимаций карты.
const pos_duration : float = .2
const rotate_duration : float = .2
const hightlight_daration : float = .2
const hightlight_height = .3  # высота подьёма выбранной карты (можно сделать глобальной)


# hand properties
var height_offset: float = 0.0 # велечина на которую нужно дополнительно поднять карту учитывая её позицию на "круге" руки. (Карты расположенные правее будут ниже)
var angle_in_hand = Vector3(0, 0, 0)  # угол карты в руке в момент её добавления. Нужен чтобы мы смогли вернуть карту в исходную позицию.
var pos_in_hand_y: float   # координаты карты в руке в момент её добавления. Нужены чтобы мы смогли вернуть карту в исходную позицию.
var over_field: FieldRow = null
var over_field_coord_x: float = INF


# tmp
var card_id : String = ""


signal mouse_entered(card: Card3D)
signal mouse_exited(card: Card3D)
signal dragging(card: Card3D)
signal dropped(card: Card3D)



# Устанавливает текст Label
func set_card_name(name) -> void:
	card_name_lbl.set_text(name)


# Функция "следования за мышкой".
# Принимает на вход координаты мышки и устанавливает меняет позицию карты, перезапысывает overfield
func follow(pos):  
	set_card_overfield()
	self.global_position.x = pos[0]
	self.global_position.y = pos[1]


func highlight():
	var mesh_instance = $CardMesh/FrontMesh
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1, 0, 0)  # Устанавливаем красный цвет
	mesh_instance.material_override = material


func unhighlight():
	var mesh_instance = $CardMesh/FrontMesh
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1, 1, 1)  # Устанавливаем красный цвет
	mesh_instance.material_override = material


func set_anim_pos(x, y):
	var tween = create_tween().set_parallel(true)
	my_tween_list.add_tween(tween)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position:x", x, pos_duration)
	tween.tween_property(self, "position:y", y, pos_duration)


func set_anim_rotation_degrees(angle):
	var tween = create_tween()
	my_tween_list.add_tween(tween)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rotation_degrees", angle, rotate_duration)


# Прерывает все анимации, делает карту hightlight.
# Необходимо для корректного отображения карты в случае если пользователь хватает её (начинает новые анимации) до завершения текущих.
func stop_all_tween_animations():
	var my_tween_list_lenght = len(my_tween_list.get_list())
	my_tween_list.kill_all() # Останавливаем все анимации которые проиходят в данный момент

	if my_tween_list_lenght > 0: # Если такие анимации есть, то после их прерывания необходимо привести их в конечное состояние. Перетаскиваемая карта - selected. А значит hightlight.
		self.set_scale(Vector3(0.2, 0.2, 0.2)) # Делаем карту подсвеченной
		self.set_rotation_degrees(Vector3(0, 0, 0))
		self.set_position(Vector3(self.position[0], pos_in_hand_y + hightlight_height + height_offset, self.position[2]))
	

func _on_static_body_3d_mouse_entered() -> void:
	mouse_entered.emit(self)


func _on_static_body_3d_mouse_exited() -> void:
	mouse_exited.emit(self)


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:

	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT:
			
			if event.pressed:
				dragging.emit(self)
				is_drag = true

			else:
				if is_drag:
					dropped.emit(self)
				is_drag = false
		
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			Global.CARD_PREVIEW.add_card_preview(self)


# Возвращает объект Field если карта над ним находиться, иначе null
func set_card_overfield() -> void:
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var collider_parent = collider.get_parent_node_3d()
		
		if collider_parent != over_field && over_field:
			over_field.precalculate_all_card_position()
			over_field = null
			over_field_coord_x = INF
		
		if collider_parent is FieldRow:
			var collision_point = raycast.get_collision_point()
			over_field = collider_parent
			over_field_coord_x = over_field.to_local(collision_point).x
			over_field.move_for_fall(self)
			
		return 
	
	if over_field:
		over_field.precalculate_all_card_position()
		over_field = null
		over_field_coord_x = INF
