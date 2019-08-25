extends Area2D

func _on_Area2D_body_entered(body: PhysicsBody2D):
	if body is PlayerBody2D:
		if self.is_in_group("ladders"): body.on_ladder = true
		if self.is_in_group("above_ladders"): body.above_ladder = true

func _on_Area2D_body_exited(body):
	if body is PlayerBody2D:
		if self.is_in_group("ladders"): body.on_ladder = false
		if self.is_in_group("above_ladders"): body.above_ladder = false
