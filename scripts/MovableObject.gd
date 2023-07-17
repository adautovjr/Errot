class_name Moveable_Object extends InteractableObject

const GRIP = 0.15

@export var WEIGHT = 0.25
var holdingObject = false
var pushingObject = false
var drop_point
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	drop_point = global_position
	

func interaction_method(value):
	slide(Vector2(value, 0.0))
	pushingObject = true
	pass


func _on_interactable_area_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") and GameManager.active_spell == "telekinesis":
		for index in get_slide_collision_count():
			if get_slide_collision(index).get_collider() is Player:
				return
		holdingObject = true
		drop_point = global_position
		Events.emit_signal("is_using_magic", true)

func _physics_process(_delta):
	if not holdingObject:
		if not is_on_floor():
			velocity.y += gravity * WEIGHT
		else:
			velocity.y = 0.0
			if not pushingObject:
				velocity.x = lerp(velocity.x, 0.0, GRIP)
		move_and_slide()
		pushingObject = false
		return

	var force_direction = 5 * ((get_global_mouse_position() - global_position))
	
	velocity = force_direction
	move_and_slide()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			drop()


func slide(direction):
	velocity.x = direction.x


func drop():
	print("Dropped")
	holdingObject = false
	Events.emit_signal("is_using_magic", false)


func _on_body_entered(_body):
	print("Collided")
	drop()
