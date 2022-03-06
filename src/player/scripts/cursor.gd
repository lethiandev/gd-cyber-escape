extends Sprite

export var root_node = NodePath()
export var target_node = NodePath()

func _process(p_delta: float) -> void:
	if has_node(root_node) and has_node(target_node):
		var root = get_node(root_node).global_position
		var target = get_node(target_node).target_position
		global_position = root + target
	update()

func _draw() -> void:
	var color = Color("40bdff8c")
	var target = get_node(target_node).target_position
	draw_line(Vector2(), -target, color, 1.025, true)
