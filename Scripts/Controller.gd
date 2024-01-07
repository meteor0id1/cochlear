extends Node

var game_mode = ""
var difficulty = 1

func load_game():
	get_tree().change_scene_to_file("res://Scenes/" + game_mode + ".tscn")
