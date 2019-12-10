extends Node
class_name Debug

# This script contains debug features and is autoloaded into the game:
# https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html

onready var player: Player = get_node("/root/Main/Player/Sprite") as Player

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
func _input(event: InputEvent) -> void:
	if not event is InputEventKey: return
	if not event.is_pressed(): return
	if event.is_echo(): return
	
	if event.scancode == KEY_Z:
		player.set_mood_for(Player.Mood.HAPPY, 1.5)
	if event.scancode == KEY_X:
		player.set_mood(Player.Mood.NEUTRAL)
	if event.scancode == KEY_C:
		player.set_mood_for(Player.Mood.SAD, 1.5)
	if event.scancode == KEY_Q:
		GameState._on_player_won()
	if event.scancode == KEY_E:
		GameState._on_game_over()
		
	if event.scancode == KEY_R:
		get_tree().reload_current_scene()
