extends PanelContainer

@onready var back_button = %BackButton
@onready var score_label = %ScoreLabel
@onready var lives_label = %LivesLabel


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ModeSelect.tscn")
	AudioManager.stop_background()

func _on_game_update_score(score):
	score_label.text = str(score)

func _on_game_update_lives(lives):
	lives_label.text = "<3 " + str(lives)
