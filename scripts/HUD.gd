extends CanvasLayer


func _ready():
	Events.connect("set_active_item", set_active_item_sprite)
	Events.connect("set_inactive_item", set_inactive_item)


func set_active_item_sprite(item):
	match item:
		"key":
			$MarginContainer/TextureRect.visible = true
		_:
			print("No idea what to show for this active item")

func set_inactive_item():
	$MarginContainer/TextureRect.visible = false
