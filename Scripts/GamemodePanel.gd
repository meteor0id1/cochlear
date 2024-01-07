extends PanelContainer

@onready var high_score_label = %HighScoreLabel
@onready var title_label = %TitleLabel

func load_info(title):
	title_label.text = title
	high_score_label.text = "High Score: " + str(Save.data.high_scores[title])
	

func _on_easy_button_pressed():
	Controller.game_mode = title_label.text
	Controller.difficulty = 2
	Controller.load_game()

func _on_medium_button_pressed():
	Controller.game_mode = title_label.text
	Controller.difficulty = 3
	Controller.load_game()

func _on_hard_button_pressed():
	Controller.game_mode = title_label.text
	Controller.difficulty = 4
	Controller.load_game()
