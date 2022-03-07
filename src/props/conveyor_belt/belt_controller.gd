extends Node2D

export var belt_speed = 10.0 \
	setget set_belt_speed, get_belt_speed


func _ready() -> void:
	set_belt_speed(belt_speed)


func set_belt_speed(p_speed: float) -> void:
	belt_speed = p_speed
	for child in get_children():
		if child.has_method("set_belt_speed"):
			child.set_belt_speed(belt_speed)

func get_belt_speed() -> float:
	return belt_speed
