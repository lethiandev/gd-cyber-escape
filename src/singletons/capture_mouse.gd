extends Node

var capture = true \
	setget set_capture, get_capture

func _ready() -> void:
	_update_capture()

func _input(p_event: InputEvent) -> void:
	# Re-capture mouse on every window interaction
	if p_event is InputEventMouseButton:
		_update_capture()

func set_capture(p_capture: bool) -> void:
	capture = p_capture
	_update_capture()

func get_capture() -> bool:
	return capture

func _update_capture() -> void:
	var mode = Input.MOUSE_MODE_CAPTURED if capture else Input.MOUSE_MODE_VISIBLE
	Input.set_mouse_mode(mode)
