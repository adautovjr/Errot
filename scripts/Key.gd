class_name Key extends InteractableObject

func interaction_method(_value):
	print("Got key")
	Events.emit_signal("set_active_item", "key")
	queue_free()
	pass
