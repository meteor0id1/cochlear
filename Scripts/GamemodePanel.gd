extends PanelContainer

@onready var high_score_label = %HighScoreLabel
@onready var title_label = %TitleLabel

func load_info(title):
	title_label.text = title
	high_score_label.text = "High Score: " + str(Save.data.high_score)
	

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
