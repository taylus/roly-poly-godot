extends Node2D
class_name FoodSpawner

@export var foods: Array # (Array, PackedScene)

@onready var food_spawn_timer = get_node("Spawn Timer")
@onready var hunger_meter = get_node("/root/Main/UI/HungerMeter")

func _ready() -> void:
	randomize()
	_spawn_random_food()

func _on_Spawn_Timer_timeout() -> void:
	if GameState.paused: return
	_spawn_random_food()

func _spawn_random_food() -> void:
	var food = _get_random_food()
	#print("Spawned: %s \"%s\"" % [food, food.name])
	_configure(food)
	add_child(food)
	
	# have the spawner go dormant after spawning food,
	# reactivating when food is either eaten or disappears,
	# so that food doesn't keep spawning and piling up
	food_spawn_timer.paused = true
	
func _configure(food: Food) -> void:
	food.scale = Vector2(0.5, 0.5)  		  # why are the sprites too big w/o this?
	food.get_node("Sprite2D").z_index = -1   # draw food behind pipes
	food.connect("eaten", Callable(self, "_on_food_eaten"))
	food.connect("expired", Callable(self, "_on_food_expired"))
	if hunger_meter != null:
		food.connect("eaten", Callable(hunger_meter, "_on_food_eaten"))
	
func _on_food_eaten(food: Food) -> void:
	food_spawn_timer.paused = false
	
func _on_food_expired() -> void:
	food_spawn_timer.paused = false
	
func _get_random_food() -> Food:
	var scene = _get_random_food_scene()
	if scene == null: return null
	return scene.instantiate()
	
func _get_random_food_scene() -> PackedScene:
	if foods.size() == 0: return null
	return foods[randf_range(0, foods.size())]
