extends Node2D

@onready var sfx = $SFX
@onready var music = $Music


func _ready():
	music.play()
	Events.connect("play_click_sound", play_click_sound)
	Events.connect("play_tick_sound", play_tick_sound)


func play_click_sound():
	sfx.stream = load("res://assets/audio/kenney_ui-audio/click1.ogg")
	sfx.play()

func play_tick_sound():
	sfx.stream = load("res://assets/audio/kenney_ui-audio/click3.ogg")
	sfx.play()
