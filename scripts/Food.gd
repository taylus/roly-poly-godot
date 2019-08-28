extends RigidBody2D
class_name Food

export var tasty: bool

func _on_body_entered(body: PhysicsBody2D):
	print(body)
