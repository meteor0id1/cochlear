extends PanelContainer

@onready var high_score_label = %HighScoreLabel
@onready var title_label = %TitleLabel

func load_info(title):
	title_label.text = title
	high_score_label.text = "High Score: " + str(Save.data.high_score)
	

func _on_easy_button_pressed():
	Controller.difficulty = 2
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_medium_button_pressed():
	Controller.difficulty = 3
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_hard_button_pressed():
	Controller.difficulty = 4
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
