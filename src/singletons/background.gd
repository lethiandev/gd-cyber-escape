extends Node

var background_color = Color.black \
	setget set_background_color, get_background_color

func _ready():
	set_background_color(background_color)

func set_background_color(p_color: Color) -> void:
	background_color = p_color
	var color = background_color
	VisualServer.set_default_clear_color(color)

func get_background_color() -> Color:
	return background_color
