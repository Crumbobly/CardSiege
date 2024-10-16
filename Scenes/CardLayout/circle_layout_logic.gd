extends Object
class_name CircleLayoutLogic

var circle_radius: float

func _init(cirlce_radius: float) -> void:
	circle_radius = cirlce_radius


"""
Функция нахождения позиции на сфере (оси X и Y - круг).
Вход: Угол как для обычного координатного круга
Выход: координаты точки, угол (в градусах) между 0углом и точкой.
"""
func get_card_position(angle_xy: float):
	# 90 т.к. для "руки" 0угол это верх круга.
	angle_xy = abs(angle_xy - 90)
	var radius: float = self.circle_radius
	var x: float = radius * cos(deg_to_rad(angle_xy))
	var y: float = radius * sin(deg_to_rad(angle_xy))
	var k: float = get_vector_angle(x, y, 0, 1)
	return [x, y, k]

"""
Функция нахождения угла между векторами (оси X и Y - круг)
Вход: Две точки
Выход: Угол в градусах
"""
func get_vector_angle(x1: float, y1: float, x2: float, y2: float):
	var angle = acos(
		(abs(x1*x2) + abs(y1*y2))
		/
		(sqrt(pow(x1, 2) + pow(y1, 2)) * sqrt(pow(x2, 2) + pow(y2, 2)))
	)
	if (x1 < 0):
		return rad_to_deg(-angle)
	return rad_to_deg(angle)
	


	
	
