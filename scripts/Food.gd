extends KinematicBody2D
class_name Food

export var tasty: bool
export var texture: Texture
export var score: int

func _ready() -> void:
	if texture: get_node("Sprite").texture = texture

func _physics_process(delta: float) -> void:
	_fall_with_gravity()
	
func _fall_with_gravity(gravity: Vector2 = Vector2(0, 1)):
	move_and_collide(gravity)

# TODO: have the player look up if food is above him,
# and look up + smile if the food is tasty -- 
# will make catching food right off the conveyor look cute

func _on_PlayerHitDetectionArea_area_entered(area: Area2D):
	print("Food _on_body_entered w/ %s \"%s\"" % [str(area), area.name])
	if not area.is_in_group("player"): return
	var player = _try_get_player_from(area)
	if player: player.set_mood_for(Player.Mood.HAPPY if tasty else Player.Mood.SAD, 1.5)
	# TODO: do additional stuff after eating the food:
	#       * play sound based on food type
	#       * adjust score based on food type
	queue_free()
	
func _try_get_player_from(area: Area2D) -> Node:
	return area.get_parent().find_node("Sprite")