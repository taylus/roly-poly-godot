extends Sprite
class_name Player

const Mood = {
	NEUTRAL = "neutral",
	HAPPY = "happy",
	SAD = "sad"	
}

var current_mood: String = Mood.NEUTRAL
var current_idle_frame: int = 0
var mood_reset_timer: Timer = Timer.new()

var idle_frames = {
	"neutral": [
		preload("res://gfx/slime_idle_neutral_1.png"),
		preload("res://gfx/slime_idle_neutral_2.png")
	],
	"happy": [
		preload("res://gfx/slime_idle_happy_1.png"),
		preload("res://gfx/slime_idle_happy_2.png")
	],
	"sad": [
		preload("res://gfx/slime_idle_sad_1.png"),
		preload("res://gfx/slime_idle_sad_2.png")
	]
}

var anim_frames = {
	"jump": preload("res://gfx/slime_jump.png")
}

onready var idle_anim_timer: Timer = $"Idle Animation Timer"

func _ready() -> void:
	add_child(mood_reset_timer)

func set_mood(mood: String) -> void:
	#print("Setting player mood to \"%s\"" % mood)
	current_mood = mood
	_update_texture_based_on_mood()
	
func start_jump() -> void:
	idle_anim_timer.paused = true
	mood_reset_timer.stop()
	set_mood(Mood.NEUTRAL)
	texture = anim_frames.jump
	
func end_jump() -> void:
	_update_texture_based_on_mood()
	idle_anim_timer.paused = false
	
# set the current mood for duration seconds, then return to neutral
func set_mood_for(mood: String, duration: float) -> void:
	set_mood(mood)
	mood_reset_timer.start(duration)
	yield(mood_reset_timer, "timeout")
	set_mood(Mood.NEUTRAL)

func _on_Idle_Animation_Timer_timeout() -> void:
	if GameState.paused: return
	current_idle_frame = 1 if current_idle_frame == 0 else 0
	_update_texture_based_on_mood()
	
func _update_texture_based_on_mood() -> void:
	if not idle_frames.has(current_mood): return
	var frames = idle_frames[current_mood]
	
	if current_idle_frame > frames.size() - 1: return
	texture = frames[current_idle_frame]
