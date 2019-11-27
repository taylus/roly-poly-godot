extends Node2D
class_name FoodSpawner

export(Array, PackedScene) var foods

func _ready() -> void:
	randomize()

func _on_Spawn_Timer_timeout() -> void:
	_spawn_random_food()

func _spawn_random_food() -> void:
	var scene = _get_random_food_scene()
	if scene == null: return
	var food = scene.instance()
	food.scale = Vector2(0.5, 0.5)	# why are the foods too big w/o this?
	print("Spawned: %s \"%s\"" % [food, food.name])
	add_child(food)
	
func _get_random_food_scene() -> PackedScene:
	if foods.size() == 0: return null
	return foods[rand_range(0, foods.size())]