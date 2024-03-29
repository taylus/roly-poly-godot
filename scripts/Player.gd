extends Sprite2D
class_name Player

const Mood = {
	NEUTRAL = "neutral",
	HAPPY = "happy",
	SAD = "sad"	
}

var currentMood: String = Mood.NEUTRAL
var currentIdleFrame: int = 0
var moodResetTimer: Timer = Timer.new()

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

@onready var idle_anim_timer: Timer = $"Idle Animation Timer"

func _ready() -> void:
	add_child(moodResetTimer)

func set_mood(mood: String) -> void:
	#print("Setting player mood to \"%s\"" % mood)
	currentMood = mood
	_update_texture_based_on_mood()
	
# set the current mood for duration seconds, then return to neutral
func set_mood_for(mood: String, duration: float) -> void:
	set_mood(mood)
	moodResetTimer.start(duration)
	await moodResetTimer.timeout
	set_mood(Mood.NEUTRAL)

func _on_Idle_Animation_Timer_timeout() -> void:
	if GameState.paused: return
	currentIdleFrame = 1 if currentIdleFrame == 0 else 0
	_update_texture_based_on_mood()
	
func _update_texture_based_on_mood() -> void:
	if not idle_frames.has(currentMood): return
	var frames = idle_frames[currentMood]
	
	if currentIdleFrame > frames.size() - 1: return
	texture = frames[currentIdleFrame]
