extends Control

signal panel_create

@export var gamemodes = [
	{
		"title" = "Vowel Identification",
		"texture" = ""
	},
	{
		"title" = "Consonant Identification",
		"texture" = ""
	},
	{
		"title" = "Word Match",
		"texture" = ""
	},
]

@export var gamemode_panel: PackedScene
@onready var gamemode_container = %GamemodeContainer
@onready var scroll_container = %ScrollContainer

func _ready():
	scroll_container.get_v_scroll_bar().custom_minimum_size.x = 12
	
	for gamemode in gamemodes:
		var new_panel = gamemode_panel.instantiate()
		gamemode_container.add_child(new_panel)
		new_panel.load_info(gamemode.title)
		var texture = StyleBoxTexture.new()
		texture.texture = gamemode.texture
		texture.set_texture_margin_all(40)
		texture.set_content_margin_all(0)
		new_panel.add_theme_stylebox_override("panel", texture)

func _on_back_button_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
