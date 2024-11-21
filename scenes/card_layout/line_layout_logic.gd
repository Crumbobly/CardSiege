extends Object
class_name LineLayoutLogic



func distribute_points_with_max_distance(n: int,  collision_shape : CollisionShape3D, step=0.2):
	if n <= 0:
		return []
		
	var corners = _get_collider_corner(collision_shape)
	var left = corners[0].x
	var right = corners[1].x

	var points = []
	
	# Центр отрезка
	var start = (left + right) / 2

	if n % 2 == 0:
		for i in range(n / 2):
			points.append(start + step * i + step / 2)
			points.append(start - step * i - step / 2)
	else:
		points.append(start)
		for i in range((n - 1) / 2):
			points.append(start + step * i + step)
			points.append(start - step * i - step)

	
	# Сортировка точек по возрастанию координат
	points.sort()
	
	return points
	


func _get_collider_corner(collision_shape):
	var _shape = collision_shape
	var obj_shape = _shape.shape
	if obj_shape is BoxShape3D:
			var extents = obj_shape.size
			var pos = _shape.global_transform
			var center = pos.origin
			var half_size = extents * .5
			
			var corners = [
				center + Vector3(pos.basis.tdotx(Vector3(half_size.x, 0, 0)),pos.basis.tdoty(Vector3(0, half_size.y, 0)), pos.basis.tdotz(Vector3(0, 0, half_size.z))),
				center + Vector3(pos.basis.tdotx(Vector3(-half_size.x, 0, 0)),pos.basis.tdoty(Vector3(0, half_size.y, 0)), pos.basis.tdotz(Vector3(0, 0, half_size.z))),
				center + Vector3(pos.basis.tdotx(Vector3(half_size.x, 0, 0)),pos.basis.tdoty(Vector3(0, half_size.y * -1, 0)), pos.basis.tdotz(Vector3(0, 0, half_size.z))),
				center + Vector3(pos.basis.tdotx(Vector3(-half_size.x, 0, 0)),pos.basis.tdoty(Vector3(0, half_size.y * -1, 0)), pos.basis.tdotz(Vector3(0, 0, half_size.z))),
			]
			return corners
