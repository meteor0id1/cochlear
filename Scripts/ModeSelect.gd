extends Control

signal panel_create


@export var gamemodes = [
	{
		"title" = "Vowel Identification",
		"texture" = "",
		"description" = "Listen to the given word and choose the corresponding answer choice, with the added challenge of background noise. More difficult levels award more points per correct answer.",
		"level_1_description" = "Two answer options with light background noise.",
		"level_2_description" = "Three answer options with medium background noise.",
		"level_3_description" = "Four answer options with loud background noise.",
	},
	{
		"title" = "Consonant Identification",
		"texture" = "",
		"description" = "Listen to the given word and choose the corresponding answer choice, with the added challenge of background noise. More difficult levels award more points per correct answer.",
		"level_1_description" = "Two answer options with light background noise.",
		"level_2_description" = "Three answer options with medium background noise.",
		"level_3_description" = "Four answer options with loud background noise.",
	},
	{
		"title" = "Word Match",
		"texture" = "",
		"description" = "Listen to the given word and choose the corresponding answer choice, with the added challenge of background noise. More difficult levels award more points per correct answer.",
		"level_1_description" = "Two answer options with light background noise.",
		"level_2_description" = "Three answer options with medium background noise.",
		"level_3_description" = "Four answer options with loud background noise.",
	},
]

@export var gamemode_panel: PackedScene
@onready var gamemode_container = %GamemodeContainer
@onready var scroll_container = %ScrollContainer
@onready var help_panel = %HelpPanel
@onready var gamemode_name = %GamemodeName
@onready var gamemode_description = %GamemodeDescription
@onready var level_1_description = %Level1Description
@onready var level_2_description = %Level2Description
@onready var level_3_description = %Level3Description


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
		new_panel.show_help.connect(show_help_menu)

func show_help_menu(gamemode):
	var gamemode_data
	for mode in gamemodes:
		if mode.title == gamemode:
			gamemode_data = mode
	if gamemode_data == null:
		return
	
	scroll_container.visible = false
	help_panel.visible = true
	gamemode_name.text = gamemode_data.title
	gamemode_description.text = gamemode_data.description
	level_1_description.text = gamemode_data.level_1_description
	level_2_description.text = gamemode_data.level_2_description
	level_3_description.text = gamemode_data.level_3_description

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_confirm_button_pressed():
	help_panel.visible = false
	scroll_container.visible = true
