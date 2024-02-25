extends Node

@export var sounds = {
	Correct = "res://Audio/SFX/confirmation_002.ogg",
	Incorrect = "res://Audio/SFX/error_006.ogg",
	WooshIn = "res://Audio/SFX/maximize_003.ogg",
	WooshOut = "res://Audio/SFX/minimize_003.ogg"
}

@export var background_sounds = [
	"",
	"",
	"res://Audio/Background/park_ambiance.wav",
	"res://Audio/Background/cafe_ambiance.wav",
	"res://Audio/Background/bus_ambiance.wav"
]

var current_background = null

func play_sound(id):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(delete_player.bind(audio_player))
	var sound = load(sounds[id])
	audio_player.stream = sound
	audio_player.play()

func play_word(word):
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.finished.connect(delete_player.bind(audio_player))
	var sound = load("res://Audio/Words/Set1/" + word + ".ogg")
	audio_player.stream = sound
	audio_player.play()

func play_background(id):
	var audio_player = AudioStreamPlayer.new()
	current_background = audio_player
	audio_player.volume_db = -10
	add_child(audio_player)
	audio_player.finished.connect(resume_background)
	var sound = load(background_sounds[id])
	audio_player.stream = sound
	audio_player.play()

func pause_background():
	if current_background:
		current_background.stop()

func resume_background():
	if current_background:
		current_background.play()

func stop_background():
	if current_background:
		current_background.queue_free()
		current_background = null

func delete_player(audio_player):
	audio_player.queue_free()
	
