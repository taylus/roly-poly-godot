extends TextureProgress
class_name HungerMeter

func _on_food_eaten(food: Food) -> void:
	value += food.score
