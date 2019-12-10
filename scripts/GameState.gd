extends Node

var paused: bool = false

onready var player: Player = get_node("/root/Main/Player/Sprite") as Player

func _on_player_won() -> void:
	print("You won!") # TODO: fancy screen/sound effects
	if player: player.set_mood(Player.Mood.HAPPY)
	paused = true
	
func _on_game_over() -> void:
	print("Game over...") # TODO: fancy screen/sound effects
	if player: player.set_mood(Player.Mood.SAD)
	paused = true
	
func load_level() -> void:
	# TODO: load a given scene like this:
	# https://github.com/taylus/godot/blob/master/Games/PlanetaryDefense/scripts/main.gd
	pass
