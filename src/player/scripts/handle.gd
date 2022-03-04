extends Area2D

var grabbing = false

func _physics_process(p_delta: float) -> void:
	if not $PinJoint2D.node_b and grabbing:
		$PinJoint2D.node_b = _get_grab_body()

func _get_grab_body() -> NodePath:
	var bodies = get_overlapping_bodies()
	if bodies and not bodies.empty():
		var body = bodies.front()
		var path = $PinJoint2D.get_path_to(body)
		return path
	return NodePath()

func grab() -> void:
	grabbing = true

func release() -> void:
	$PinJoint2D.node_b = NodePath()
	grabbing = false
