extends RigidBody2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(p_body: PhysicsBody2D) -> void:
	var speed = linear_velocity.length() + angular_velocity * 0.2
	if speed > 6.0 and not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.volume_db = -20.0 * (1.0 - clamp(speed / 50.0, 0.0, 1.0))
		$AudioStreamPlayer.play()
