extends RigidBody2D

func _ready() -> void:
	connect("body_shape_entered", self, "_on_body_shape_entered")

func _on_body_shape_entered(body_rid, body, body_idx, local_idx) -> void:
	if not $AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.play()
