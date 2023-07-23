extends Node

var available_spells = []
var active_spell = null

var active_item_sprite = null


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("add_new_spell", add_spell)
	Events.connect("set_active_item", set_active_item_sprite)


func add_spell(spell):
	if not available_spells.has(spell):
		available_spells.push_back(spell)
	if (available_spells.size() == 1):
		active_spell = spell

func set_active_item_sprite(item):
	active_item_sprite = item
