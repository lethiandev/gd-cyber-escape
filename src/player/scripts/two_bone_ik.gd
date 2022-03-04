extends Node2D

export var upper_arm = NodePath()
export var upper_length = 10.0

export var lower_arm = NodePath()
export var lower_length = 10.0

export var target_position = Vector2()
export var joint_flipped = false

func _physics_process(p_delta: float) -> void:
	var s = solve_ik(upper_length, lower_length, joint_flipped, target_position)
	# Add half PI to fix target rotation
	get_node(upper_arm).target_rotation = s[0]
	get_node(lower_arm).target_rotation = s[0] + s[1]

func clamp_target_position() -> void:
	var total_len = upper_length + lower_length
	target_position = target_position.clamped(total_len)

func solve_ik(len1: float, len2: float, flip: bool, target: Vector2) -> Array:
	var targetsqr = target.length_squared()
	var cosangle2_denom = 2.0*len1*len2
	
	var cosangle2 = (targetsqr  - len1*len1 - len2*len2) / cosangle2_denom
	cosangle2 = clamp(cosangle2, -1.0, 1.0)
	
	var flipped = 1.0 if flip else -1.0
	var angle2 = acos(cosangle2) * flipped
	var sinangle2 = sin(angle2)
	
	var triadj = len1 + len2*cosangle2
	var triopp = len2*sinangle2
	
	var tany = target.y*triadj - target.x*triopp
	var tanx = target.x*triadj + target.y*triopp
	
	var angle1 = atan2(tany, tanx)
	return [angle1, angle2]
