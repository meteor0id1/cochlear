extends Control

signal panel_create

var gamemodes = [
	{
		"title" = "Word Match",
		"high_score" = 0,
	},
	{
		"title" = "Sentence \nComprehension",
		"high_score" = 0,
	},
	{
		"title" = "Word Match",
		"high_score" = 0,
	},
	{
		"title" = "Word Match",
		"high_score" = 0,
	},
]

@export var gamemode_panel: PackedScene
@onready var gamemode_container = %GamemodeContainer

func _ready():
	for gamemode in gamemodes:
		var new_panel = gamemode_panel.instantiate()
		gamemode_container.add_child(new_panel)
		new_panel.load_info(gamemode.title)

func _on_back_button_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
