extends Node

export(String, FILE, "*.tscn") var next_stage: String


func _ready() -> void:
	EventBus.connect("player_killed", self, "_on_player_killed")
	EventBus.connect("player_teleported", self, "_on_player_teleported")
	Transition.fade_in()


func _on_player_teleported(p_player: Node) -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	_goto_next_stage()

func _on_player_killed(p_player: Node) -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	_goto_restart()


func _goto_next_stage() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().change_scene(next_stage)

func _goto_restart() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().reload_current_scene()
