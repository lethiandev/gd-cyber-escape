extends Node

signal player_killed(player)
signal player_teleported(player)


func emit_player_killed(p_player: Node) -> void:
	emit_signal("player_killed", p_player)

func emit_player_teleported(p_player: Node) -> void:
	emit_signal("player_teleported", p_player)
