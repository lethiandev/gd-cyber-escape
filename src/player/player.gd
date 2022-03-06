extends Node2D

signal player_teleported()
signal player_killed()

export var enabled = true \
	setget set_enabled, is_enabled

export var flipped = false \
	setget set_flipped, is_flipped

var teleported = false
var killed = false


func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		var relpos = p_event.relative * 0.2
		$IKArm.target_position += relpos
		$IKArm.clamp_target_position()

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		kill()
	if not enabled or killed:
		return
	if Input.is_action_just_pressed("flip_side"):
		set_flipped(not flipped)
	if Input.is_action_just_pressed("grab"):
		$IKArm/LowerArm/HandleArea2D.grab()
	if Input.is_action_just_released("grab"):
		$IKArm/LowerArm/HandleArea2D.release()

func teleport() -> void:
	if teleported:
		return
	teleported = true
	# Make player's body static
	$Chest.mode = RigidBody2D.MODE_KINEMATIC
	$Head.mode = RigidBody2D.MODE_KINEMATIC
	$IKArm/UpperArm.mode = RigidBody2D.MODE_KINEMATIC
	$IKArm/LowerArm.mode = RigidBody2D.MODE_KINEMATIC
	# Hide colored limbs' sprites
	$Chest/PortalEffect.visible = true
	set_sprite_visible(false)
	set_enabled(false)
	EventBus.emit_player_teleported(self)

func kill() -> void:
	if killed:
		return
	killed = true
	$Head/PinJoint2D.queue_free()
	$IKArm/UpperArm/PinJoint2D.queue_free()
	$IKArm/LowerArm/PinJoint2D.queue_free()
	set_enabled(false)
	EventBus.emit_player_killed(self)
	# Blink the body parts
	set_sprite_visible(false)
	yield(get_tree().create_timer(0.2), "timeout")
	set_sprite_visible(true)


func set_enabled(p_enabled: bool) -> void:
	enabled = p_enabled
	$IKArm/UpperArm.enabled = enabled
	$IKArm/LowerArm.enabled = enabled
	$World/Cursor.visible = enabled
	# Release grabbed items
	$IKArm/LowerArm/HandleArea2D.release()

func is_enabled() -> bool:
	return enabled


func set_flipped(p_flipped: bool) -> void:
	flipped = p_flipped
	$Chest/BaseSprite.flip_h = flipped
	$Chest/OutlineSprite.flip_h = flipped
	$Head/BaseSprite.flip_h = flipped
	$Head/OutlineSprite.flip_h = flipped
	$IKArm/LowerArm/BaseSprite.flip_h = flipped
	$IKArm/LowerArm/OutlineSprite.flip_h = flipped
	$IKArm/UpperArm/BaseSprite.flip_h = flipped
	$IKArm/UpperArm/OutlineSprite.flip_h = flipped
	# Flip arm joint direction too
	$IKArm.joint_flipped = flipped

func is_flipped() -> bool:
	return flipped


func _on_body_entered(p_body: PhysicsBody2D) -> void:
	if p_body and p_body.is_in_group("hurt"):
		kill()


func set_sprite_visible(p_visible: bool) -> void:
	$Chest/BaseSprite.visible = p_visible
	$Head/BaseSprite.visible = p_visible
	$IKArm/UpperArm/BaseSprite.visible = p_visible
	$IKArm/LowerArm/BaseSprite.visible = p_visible
