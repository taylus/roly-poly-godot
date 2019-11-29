extends Sprite
class_name Player

const Mood = {
	NEUTRAL = "neutral",
	HAPPY = "happy",
	SAD = "sad",
	HUNGRY = "hungry"
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
	],
	"hungry": [
		preload("res://gfx/slime_look_up_1.png"),
		preload("res://gfx/slime_look_up_2.png")
	]
}

onready var idle_anim_timer: Timer = $"Idle Animation Timer"

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
	yield(moodResetTimer, "timeout")
	set_mood(Mood.NEUTRAL)

func _on_Idle_Animation_Timer_timeout() -> void:
	currentIdleFrame = 1 if currentIdleFrame == 0 else 0
	_update_texture_based_on_mood()
	
func _update_texture_based_on_mood() -> void:
	if not idle_frames.has(currentMood): return
	var frames = idle_frames[currentMood]
	
	if currentIdleFrame > frames.size() - 1: return
	texture = frames[currentIdleFrame]

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
func _input(event: InputEvent) -> void:
	if not event is InputEventKey: return
	if not event.is_pressed(): return
	if event.is_echo(): return
	
	if event.scancode == KEY_Z:
		set_mood_for(Mood.HAPPY, 1.5)
	if event.scancode == KEY_X:
		set_mood(Mood.NEUTRAL)
	if event.scancode == KEY_C:
		set_mood_for(Mood.SAD, 1.5)
	if event.scancode == KEY_Q:
		set_mood_for(Mood.HUNGRY, 1.5)