extends CharacterBody2D
class_name PlayerBody2D

const walk_speed = 50;
const gravity = Vector2(0, 100);
var on_ladder: bool = false
var above_ladder: bool = false
@onready var sprite: Sprite2D = get_node("Sprite2D")

func _physics_process(delta: float) -> void:
	if GameState.paused: return
	var movement = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		movement = Vector2(-walk_speed, 0)
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		movement = Vector2(walk_speed, 0)
		sprite.flip_h = true
		
	if Input.is_action_pressed("ui_up") and on_ladder:
		movement += Vector2(0, -walk_speed)
	if Input.is_action_pressed("ui_down") and (on_ladder or above_ladder):
		movement += Vector2(0, walk_speed)
	
	if not (on_ladder or above_ladder): movement += gravity
	_move(movement)
		
func _move(vector: Vector2) -> void:
	set_velocity(vector)
	set_up_direction(Vector2.UP)
	move_and_slide()	# platformer, so Vector2.UP is the floor normal
