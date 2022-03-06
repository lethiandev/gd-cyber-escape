extends RigidBody2D

func _ready() -> void:
	connect("body_shape_entered", self, "_on_body_shape_entered")

func _on_body_shape_entered(body_rid, body, body_idx, local_idx) -> void:
	var has_speed = linear_velocity.length_squared() > 5.0 or angular_velocity > 5.0
	if has_speed and not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
