extends CharacterBody2D
class_name Food

signal eaten(food)
signal expired()

@export var tasty: bool
@export var score: int

func _physics_process(delta: float) -> void:
	_fall_with_gravity()
	
func _fall_with_gravity(gravity: Vector2 = Vector2(0, 1)):
	move_and_collide(gravity)

# TODO: have the player look up if food is above him,
# and look up + smile if the food is tasty -- 
# will make catching food right off the conveyor look cute

func _on_PlayerHitDetectionArea_area_entered(area: Area2D):
	#print("Food \"%s\" collided w/ %s \"%s\"" % [name, str(area), area.name])
	if not area.is_in_group("player"): return
	var player = _try_get_player_from(area)
	if player: player.set_mood_for(Player.Mood.HAPPY if tasty else Player.Mood.SAD, 2.0)
	emit_signal("eaten", self)
	# TODO: do additional stuff after eating the food:
	#       * play sound based on food type
	#       * adjust score based on food type
	queue_free()
	
func _try_get_player_from(area: Area2D) -> Player:
	return area.get_parent().find_child("Sprite2D") as Player

func _on_ExpireTimer_timeout() -> void:
	if GameState.paused: return
	var blink_duration = 4.0
	_blink_sprite(blink_duration)
	await get_tree().create_timer(blink_duration).timeout
	emit_signal("expired")
	queue_free()
	
func _blink_sprite(duration: float, blinks: int = 4) -> void:
	for i in range(blinks):
		modulate.a = 0
		await get_tree().create_timer(duration / blinks / 2).timeout
		modulate.a = 1
		await get_tree().create_timer(duration / blinks / 2).timeout