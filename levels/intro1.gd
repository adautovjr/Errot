extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	play("intro1")

func _on_AnimationPlayer_animation_finished(_anim_name):
	go_to_next_scene()

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		go_to_next_scene()


func go_to_next_scene():
	get_tree().change_scene_to_packed(load("res://levels/home.tscn"))
