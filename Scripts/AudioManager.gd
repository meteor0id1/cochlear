extends Node

@export var sounds = {
	Correct = "res://Audio/confirmation_002.ogg",
	Incorrect = "res://Audio/error_006.ogg",
	WooshIn = "res://Audio/maximize_003.ogg",
	WooshOut = "res://Audio/minimize_003.ogg"
}

@onready var audio_player = $AudioPlayer

func _play_sound(id):
	var sound = load(sounds[id])
	audio_player.stream = sound
	audio_player.play()
