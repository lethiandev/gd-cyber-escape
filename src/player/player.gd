extends Node2D

var flipped = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		var relpos = p_event.relative * 0.2
		$IKArm.target_position += relpos
		$IKArm.clamp_target_position()

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("flip_side"):
		flipped = not flipped
		_flip_side(flipped)
	if Input.is_action_just_pressed("grab"):
		$IKArm/LowerArm/HandleArea2D.grab()
	if Input.is_action_just_released("grab"):
		$IKArm/LowerArm/HandleArea2D.release()
	update()

func _flip_side(p_flipped: bool) -> void:
	$Chest/BaseSprite.flip_h = p_flipped
	$Chest/OutlineSprite.flip_h = p_flipped
	$Head/BaseSprite.flip_h = p_flipped
	$Head/OutlineSprite.flip_h = p_flipped
	$IKArm.joint_flipped = p_flipped
	$IKArm/LowerArm/BaseSprite.flip_h = p_flipped
	$IKArm/LowerArm/OutlineSprite.flip_h = p_flipped
	$IKArm/UpperArm/BaseSprite.flip_h = p_flipped
	$IKArm/UpperArm/OutlineSprite.flip_h = p_flipped
