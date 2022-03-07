extends Node

export(String, FILE, "*.tscn") var next_stage: String


func _ready() -> void:
	set_process_input(false)
	yield(Transition.fade_in(), "completed")
	set_process_input(true)

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton:
		set_process_input(false)
		_goto_next_stage()


func _goto_next_stage() -> void:
	yield(Transition.fade_out(), "completed")
	get_tree().change_scene(next_stage)
