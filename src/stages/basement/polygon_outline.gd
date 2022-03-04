extends StaticBody2D

func _draw() -> void:
	var color = Color("1e405b")
	for child in get_children():
		if child is Polygon2D:
			draw_polyline(child.polygon, color, 4.0, true)
