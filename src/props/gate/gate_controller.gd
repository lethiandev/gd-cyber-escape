extends Node2D

export var open_time = 0.333
export var open_distance = 41.0

export var opened = false \
	setget set_opened, is_opened


func _ready() -> void:
	set_opened(opened)


func set_opened(p_open: bool) -> void:
	opened = p_open
	# Tween gate position to open/close the gate
	var to = Vector2(0.0, -open_distance) if opened else Vector2()
	_tween_gate_position(to)

func is_opened() -> bool:
	return opened


func _tween_gate_position(p_offset: Vector2) -> void:
	$Tween.remove_all()
	$Tween.interpolate_property($Gate, "position", $Gate.position, p_offset, open_time, Tween.TRANS_LINEAR)
	$Tween.start()
