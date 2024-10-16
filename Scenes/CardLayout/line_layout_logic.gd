extends Object
class_name LineLayoutLogic


"""
Фунция распределения точек на отезке.
Находит расположение точек на отрезке по следующим правилам:
	1. Расстояние между всеми (n) точками равно
	2. Расстояние между всеми (n) точками равно step если это возможно
	3. Если число точек четноё, то слева с справа от середины отрезка их число одинаково
	4. Если число точек нечетно, то середина отрезка - точка, и (3.)

In: n=4
Output: [-9, -3, 3, 9]

In: n=5
Output: [-12, -6, 0, 6, 12]

Вход: Кол-во точек, левая граница отрезка, правая граница отрезка, максимальное расстояние между точками
Выход: Список координат точек.
"""
func distribute_points_with_max_distance(n: int, left: float = -15.0, right: float = 15.0, step: float = 6.0):
	var max_n: int = (right - left ) / step
	var points = []
	var start = (left + right) / 2
	
	if n > max_n:
		step = (right - left ) / n
	
	if n % 2 == 0:
		for i in range(n / 2):
			points.append(start + step * i + step / 2)
			points.append(start - step * i - step / 2)
	else:
		points.append(start)
		for i in range((n - 1) / 2):
			points.append(start + step * i + step)
			points.append(start - step * i - step)
	
	points.sort()
	return points


# TODO (Сделать лучше)
func move_apart(n: int, selected_card_index: int, left: float = -15.0, right: float = 15.0, step: float = 6.0):
	var coords = distribute_points_with_max_distance(n)
	
	if n < 3:
		return coords
		
	var select = []
	var before = selected_card_index - 1
	if before < 0:
		before = 0
	var after = n - selected_card_index - 2
	
	if selected_card_index > 0:
		select.append(coords[selected_card_index - 1] - step * 2)
	select.append(coords[selected_card_index])
	if selected_card_index < n - 1:
		select.append(coords[selected_card_index + 1] + step * 2)
	
	var coords_before = []
	var coords_after = []
	if before > 0:
		coords_before = distribute_points_with_max_distance(before, -30, coords[selected_card_index] - step * 2.5)
	if after > 0:
		coords_after = distribute_points_with_max_distance(after, coords[selected_card_index] + step * 2.5, 30)

	return coords_before + select + coords_after
	
