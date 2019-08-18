extends Sprite

var frames = [
	preload("res://gfx/conveyor_belt.png"),
	preload("res://gfx/conveyor_belt_rotated.png")
]

var endCapFrames = [
	preload("res://gfx/conveyor_belt_end.png"),
	preload("res://gfx/conveyor_belt_end_rotated.png")
]

onready var endCap = $"End Cap"

func _on_Animation_Timer_timeout():
	texture = frames[1] if texture == frames[0] else frames[0]
	if endCap == null: return
	endCap.texture = endCapFrames[1] if endCap.texture == endCapFrames[0] else endCapFrames[0]