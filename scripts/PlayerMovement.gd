extends KinematicBody2D
class_name PlayerBody2D

const walk_speed = 80;
const jump_height = -220;
const gravity = 20;
var on_ladder: bool = false
var above_ladder: bool = false
var movement = Vector2()
onready var sprite: Sprite = get_node("Sprite")

func _physics_process(delta: float) -> void:
	if GameState.paused: return
	if not on_ladder: movement.y += gravity
	if (is_on_floor() || on_ladder) && sprite.texture == sprite.anim_frames.jump:
		sprite.end_jump()
	
	if Input.is_action_pressed("ui_left"):
		movement.x = -walk_speed
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		movement.x = walk_speed
		sprite.flip_h = true
	else:
		movement.x = 0
		
	if Input.is_action_pressed("ui_up") and on_ladder:
		movement.y = -walk_speed
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		movement.y = jump_height
		sprite.start_jump()
	elif Input.is_action_pressed("ui_down") and (on_ladder or above_ladder):
		movement.y = walk_speed
	elif on_ladder:
		movement.y = 0
		
	movement = _move(movement)
		
func _move(vector: Vector2) -> Vector2:
	return move_and_slide(vector, Vector2.UP)	# platformer, so Vector2.UP is the floor normal