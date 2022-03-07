extends StaticBody2D

export var enabled = false \
	setget set_enabled, get_enabled


func _ready():
	set_enabled(enabled)


func set_enabled(p_enabled: bool) -> void:
	enabled = p_enabled
	$Sprite.frame = 0 if enabled else 1
	$PortalEffect.visible = enabled
	$Area2D.monitoring = enabled

func get_enabled() -> bool:
	return enabled


func _on_body_entered(p_body: PhysicsBody2D) -> void:
	var player = p_body.get_parent()
	if player.has_method("teleport") and not player.teleported:
		player.call_deferred("teleport")
		$ZapPlayer.play()
