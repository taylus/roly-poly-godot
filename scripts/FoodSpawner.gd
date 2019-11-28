extends Node2D
class_name FoodSpawner

export(Array, PackedScene) var foods

onready var food_spawn_timer = $"Spawn Timer"

func _ready() -> void:
	randomize()
	_spawn_random_food()

func _on_Spawn_Timer_timeout() -> void:
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
	food.get_node("Sprite").z_index = -1   # draw food behind pipes
	food.connect("eaten_by", self, "_on_food_eaten_by")
	food.connect("expired", self, "_on_food_expired")
	
func _on_food_eaten_by(player: Player) -> void:
	food_spawn_timer.paused = false
	
func _on_food_expired() -> void:
	food_spawn_timer.paused = false
	
func _get_random_food() -> Food:
	var scene = _get_random_food_scene()
	if scene == null: return null
	return scene.instance()
	
func _get_random_food_scene() -> PackedScene:
	if foods.size() == 0: return null
	return foods[rand_range(0, foods.size())]