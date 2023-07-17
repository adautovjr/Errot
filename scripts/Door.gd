class_name Door extends InteractableObject

@export var go_to: Node2D
@export var packed_scene: PackedScene

func interaction_method(_value):
	if packed_scene is PackedScene:
		get_tree().change_scene_to_packed(packed_scene)
		return
	if go_to is Node2D:
		Events.emit_signal("move_player_to", go_to.position + Vector2(0, 69))
		return
	print("No destination set for this door")
	pass
