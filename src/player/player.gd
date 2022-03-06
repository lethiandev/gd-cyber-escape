extends Node2D

export var enabled = true \
	setget set_enabled, is_enabled

export var flipped = false \
	setget set_flipped, is_flipped


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		var relpos = p_event.relative * 0.2
		$IKArm.target_position += relpos
		$IKArm.clamp_target_position()

func _process(p_delta: float) -> void:
	if not enabled:
		return
	if Input.is_action_just_pressed("flip_side"):
		set_flipped(not flipped)
	if Input.is_action_just_pressed("grab"):
		$IKArm/LowerArm/HandleArea2D.grab()
	if Input.is_action_just_released("grab"):
		$IKArm/LowerArm/HandleArea2D.release()


func set_enabled(p_enabled: bool) -> void:
	enabled = p_enabled
	$IKArm/UpperArm.enabled = enabled
	$IKArm/LowerArm.enabled = enabled
	$World/Cursor.visible = enabled

func is_enabled() -> bool:
	return enabled


func set_flipped(p_flipped: bool) -> void:
	flipped = p_flipped
	$Chest/BaseSprite.flip_h = flipped
	$Chest/OutlineSprite.flip_h = flipped
	$Head/BaseSprite.flip_h = flipped
	$Head/OutlineSprite.flip_h = flipped
	$IKArm.joint_flipped = flipped
	$IKArm/LowerArm/BaseSprite.flip_h = flipped
	$IKArm/LowerArm/OutlineSprite.flip_h = flipped
	$IKArm/UpperArm/BaseSprite.flip_h = flipped
	$IKArm/UpperArm/OutlineSprite.flip_h = flipped

func is_flipped() -> bool:
	return flipped
