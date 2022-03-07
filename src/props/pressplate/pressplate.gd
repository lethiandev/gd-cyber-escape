extends StaticBody2D

signal plate_pressed()
signal plate_released()

var contact_bodies = 0


func _ready() -> void:
	# Add collision exception
	$Plate.add_collision_exception_with(self)


func _on_body_entered(p_body: PhysicsBody2D) -> void:
	if contact_bodies == 0:
		emit_signal("plate_pressed")
		_tween_plate_position(Vector2(0, 4))
		$ReleaseTimer.stop()
	contact_bodies += 1

func _on_body_exited(p_body: PhysicsBody2D) -> void:
	if contact_bodies == 1:
		$ReleaseTimer.start()
	contact_bodies -= 1

func _on_release_timeout():
	emit_signal("plate_released")
	_tween_plate_position(Vector2())


func _tween_plate_position(p_offset: Vector2) -> void:
	$Tween.remove_all()
	$Tween.interpolate_property($Plate, "position", $Plate.position, p_offset, 0.5, Tween.TRANS_LINEAR)
	$Tween.start()
