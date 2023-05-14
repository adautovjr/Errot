extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_area = $DetectionArea2D

var interactions_in_range: Array[InteractableObject] = []
var is_moving = false


func _physics_process(delta):
	_get_animation(delta)
	_get_action()
	move_and_slide()
	pass


############## Animation ##############

func _get_animation(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("jump")

	else:
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")


############## Movement ##############

func _get_action():
	if Input.is_action_pressed("interact"):
		_on_interaction()

	else:
		is_moving = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("get_down") and is_on_floor():
		position.y += 1

	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = clamp(velocity.x, 0, 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	_reset_detection_area_position(direction)

func _reset_detection_area_position(direction):
	if !direction || is_moving:
		return

	if (velocity.x > 0):
		detection_area.position = Vector2(13, -3)
	else:
		detection_area.position = Vector2(-13, -3)

############## Interactions ##############

func _on_interaction():
	if (interactions_in_range.size() == 0):
		return

	var current_interaction = interactions_in_range[0]

	match current_interaction.interaction_type:
		"move":
			var force = Input.get_axis("walk_left", "walk_right")
			current_interaction.interaction_method(force)
			is_moving = true
		"method":
			print("call method")
			current_interaction.interaction_method(null)
		"none":
			print("Undefined interaction")
