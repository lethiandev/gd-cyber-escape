extends StaticBody2D

export var rotation_speed = TAU \
	setget set_rotation_speed, get_rotation_speed


func _ready() -> void:
	set_rotation_speed(rotation_speed)

func _process(p_delta: float) -> void:
	$Sprite.rotate(rotation_speed * p_delta)


func set_rotation_speed(p_speed: float) -> void:
	rotation_speed = p_speed
	constant_angular_velocity = rotation_speed

func get_rotation_speed() -> float:
	return rotation_speed
