extends KinematicBody2D
class_name Food

export var tasty: bool

# TODO: have the player look up if food is above him,
# and look up + smile if the food is tasty -- 
# will make catching food right off the conveyor look cute

func _physics_process(delta: float) -> void:
	_fall_with_gravity()
	
func _fall_with_gravity(gravity: Vector2 = Vector2(0, 1)):
	move_and_collide(gravity)

func _on_PlayerHitDetectionArea_area_entered(area: Area2D):
	print("Food _on_body_entered w/ %s \"%s\"" % [str(area), area.name])
	if not area.is_in_group("player"): return
	queue_free()
	# TODO: do fancier stuff than just deleting the food:
	#       * play sound based on food type
	#       * animate player based on food type
	#       * adjust score based on food type