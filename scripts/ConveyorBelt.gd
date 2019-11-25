extends Sprite
class_name ConveyorBelt

var frames = [
	preload("res://gfx/conveyor_belt.png"),
	preload("res://gfx/conveyor_belt_rotated.png")
]

var endCapFrames = [
	preload("res://gfx/conveyor_belt_end.png"),
	preload("res://gfx/conveyor_belt_end_rotated.png")
]

onready var endCap = $"End Cap"

var bodiesToMove = []
export var movementVector: Vector2 = Vector2(4, 0)

func _on_Animation_Timer_timeout():
	texture = frames[1] if texture == frames[0] else frames[0]
	if endCap == null: return
	endCap.texture = endCapFrames[1] if endCap.texture == endCapFrames[0] else endCapFrames[0]
	
	# TODO: move into separate timer (or at least rename this timer)
	for body in bodiesToMove:
		body.move_and_collide(movementVector)

# move certain objects that enter the conveyor belt's detection area
func _on_PushArea_body_entered(body: PhysicsBody2D):
	if body is StaticBody2D: return
	print("Conveyor _on_PushArea_body_entered w/ %s \"%s\"" % [str(body), body.name])
	if body is KinematicBody2D: bodiesToMove.append(body)

func _on_PushArea_body_exited(body):
	if body is StaticBody2D: return
	print("Conveyor _on_PushArea_body_exited w/ %s \"%s\"" % [str(body), body.name])
	if body is KinematicBody2D: bodiesToMove.erase(body)
