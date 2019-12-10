extends TextureProgress
class_name HungerMeter

signal player_won()

func _ready() -> void:
	# connect signals to autoloaded script for managing the game's overall state
	if GameState: connect("player_won", GameState, "_on_player_won")

func _on_food_eaten(food: Food) -> void:
	value += food.score
	if value >= 100: emit_signal("player_won")
