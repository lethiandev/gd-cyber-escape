extends Node2D

export var belt_speed = 10.0 \
	setget set_belt_speed, get_belt_speed

export var belt_index = 0 \
	setget set_belt_index, get_belt_index


func _ready() -> void:
	set_belt_speed(belt_speed)
	set_belt_index(belt_index)

func _process(p_delta: float) -> void:
	var motion = belt_speed * p_delta
	$Belt/Sprite.region_rect.position.x -= motion


func set_belt_speed(p_speed: float) -> void:
	belt_speed = p_speed
	var motion_vector = Vector2(belt_speed, 0.0).rotated(global_rotation)
	$Belt.constant_linear_velocity = motion_vector

func get_belt_speed() -> float:
	return belt_speed


func set_belt_index(p_index: int) -> void:
	belt_index = p_index
	$Sprite.frame = belt_index
	if belt_index == 0:
		$Belt/Sprite.region_rect.position.x = 0.0
		$Belt/Sprite.region_rect.size.x = 16.0
		$Belt/Sprite.position.x = 0.0
	elif belt_index == 1:
		$Belt/Sprite.region_rect.position.x = 2.0
		$Belt/Sprite.region_rect.size.x = 14.0
		$Belt/Sprite.position.x = 1.0
	elif belt_index == 2:
		$Belt/Sprite.region_rect.position.x = 0.0
		$Belt/Sprite.region_rect.size.x = 14.0
		$Belt/Sprite.position.x = -1.0

func get_belt_index() -> int:
	return belt_index
