class_name InteractableObject extends RigidBody2D

@export var interaction_label = "none"
@export var interaction_type = "none"
@export var interaction_value = "none"


func interaction_method(_value):
	print("Interacted with ", self.name)
	pass
