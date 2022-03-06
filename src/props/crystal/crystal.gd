extends RigidBody2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(p_body: PhysicsBody2D) -> void:
	var has_speed = linear_velocity.length_squared() > 5.0 or angular_velocity > 5.0
	if has_speed and not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
