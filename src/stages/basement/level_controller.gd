extends Node

export var player_node = NodePath()

func _on_portal_entered(p_player: Node) -> void:
	if "killed" in p_player and p_player.killed:
		return
	if p_player.has_method("teleport"):
		p_player.call_deferred("teleport")
	if $OutroTimer.is_stopped():
		$OutroTimer.start()

func _on_outro_timeout():
	if has_node(player_node):
		get_node(player_node).queue_free()
