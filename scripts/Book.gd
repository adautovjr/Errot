class_name Book extends InteractableObject


func interaction_method(_p):
	Events.emit_signal("add_new_spell", interaction_value)
	$AnimationPlayer.play("read_book")


func destroy():
	queue_free()
