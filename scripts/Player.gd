extends Sprite

onready var anim_timer = get_node("Animation Timer")

var frames = [
	preload("res://gfx/slime_idle_1.png"),
	preload("res://gfx/slime_idle_2.png"),
]

var on_ladder = preload("res://gfx/slime_on_ladder.png")

func _on_Animation_Timer_timeout() -> void:
	texture = frames[1] if texture == frames[0] else frames[0]

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	if get_parent().on_ladder:
		anim_timer.paused = true
		texture = on_ladder
	else:
		anim_timer.paused = false