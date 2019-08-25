extends KinematicBody2D

const walk_speed = 50;
onready var sprite: Sprite = get_node("Sprite")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-walk_speed, 0), Vector2.UP)
		sprite.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(walk_speed, 0), Vector2.UP)
		sprite.flip_h = true