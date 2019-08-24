extends Sprite

var frames = [
	preload("res://gfx/slime_idle_1.png"),
	preload("res://gfx/slime_idle_2.png")
]

func _on_Animation_Timer_timeout() -> void:
	texture = frames[1] if texture == frames[0] else frames[0]

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()