extends Node

@export var sounds = {
	Correct = "res://Audio/SFX/confirmation_002.ogg",
	Incorrect = "res://Audio/SFX/error_006.ogg",
	WooshIn = "res://Audio/SFX/maximize_003.ogg",
	WooshOut = "res://Audio/SFX/minimize_003.ogg"
}

func play_sound(id):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(delete_player)
	var sound = load(sounds[id])
	audio_player.stream = sound
	audio_player.play()

func play_word(word):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(delete_player)
	var sound = load("res://Audio/Words/Set1/" + word + ".ogg")
	audio_player.stream = sound
	audio_player.play()

func delete_player():
	for player in get_children():
		if player.playing == false:
			player.queue_free()
	
