extends CanvasLayer

func fade_out() -> void:
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer, "animation_finished")

func fade_in() -> void:
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer, "animation_finished")
