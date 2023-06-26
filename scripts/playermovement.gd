extends CharacterBody2D
class_name Player

const SPEED = 800.0
const JUMP_VELOCITY = -1200.0
const PUSH_FORCE = 800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_area = $DetectionArea2D
@onready var IndicatorSprite = $Indicator/AnimatedSprite2D

var interactions_in_range: Array[InteractableObject] = []
var is_moving = false
var is_using_magic = false
var looking_at_right = true


func _ready():
	Events.connect("is_using_magic", _handle_using_magic)
	IndicatorSprite.play("default")


func _physics_process(delta):
	_get_animation(delta)
	_get_action()
	move_and_slide()
	pass


############## Animation ##############

func _get_animation(delta):
	if not is_on_floor():
		velocity.y += gravity * delta * 2
		if velocity.y <= 0:
			animated_sprite.play("jump")
			return 
		animated_sprite.play("fall")
		return 
	if is_using_magic:
		animated_sprite.play("magic")
		return
	if velocity.x == 0:
		if is_moving:
			animated_sprite.play("idle_push")
			return 
		animated_sprite.play("idle")
		return 
	if is_moving:
		if velocity.x < 0:
			if looking_at_right:
				animated_sprite.play("pull")
			else:
				animated_sprite.play("push")
			return 
		if looking_at_right:
			animated_sprite.play("push")
		else:
			animated_sprite.play("pull")
		return 
	animated_sprite.play("run")
	return 


############## Movement ##############

func _get_action():
	if is_using_magic:
		return

	if is_on_floor() and Input.is_action_pressed("interact"):
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
		if not is_moving:
			animated_sprite.flip_h = clamp(-velocity.x, 0, 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	_reset_detection_area_position(direction)

func _reset_detection_area_position(direction):
	if !direction || is_moving:
		return

	if (velocity.x > 0):
		detection_area.position = Vector2(70, -3)
		looking_at_right = true
	else:
		detection_area.position = Vector2(-70, -3)
		looking_at_right = false

############## Interactions ##############

func _on_interaction():
	if (interactions_in_range.size() == 0):
		return

	var current_interaction = interactions_in_range[0]

	match current_interaction.interaction_type:
		"move":
			var force = Input.get_axis("walk_left", "walk_right")
			current_interaction.interaction_method(force * PUSH_FORCE)
			is_moving = true
		"method":
			print("call method")
			current_interaction.interaction_method(null)
		"none":
			print("Undefined interaction")


func _handle_using_magic(value):
	is_using_magic = value
