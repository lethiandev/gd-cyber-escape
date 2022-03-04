extends RigidBody2D

export var target_node = NodePath()
export var target_speed = 15.0
export var target_rotation = 0.0

export var enabled = true

func _process(p_delta: float) -> void:
	if target_node and has_node(target_node):
		var target = get_node(target_node)
		target_rotation = target.global_rotation

func _integrate_forces(p_state: Physics2DDirectBodyState) -> void:
	if not enabled:
		return
	var angle = angle_diff(global_rotation, target_rotation)
	p_state.angular_velocity = angle * target_speed

func angle_diff(from, to):
	return fposmod(to - from + PI, TAU) - PI
