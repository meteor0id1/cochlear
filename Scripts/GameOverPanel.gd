extends ColorRect

@onready var high_score_label = $HighScoreLabel
@onready var final_score_label = $FinalScoreLabel

func _ready():
	visible = false

func _on_game_over(final_score):
	if final_score > Save.data.high_scores[Controller.game_mode]:
		Save.data.high_scores[Controller.game_mode] = final_score
		Save.save_data()
	
	final_score_label.text = "Final Score: " + str(final_score)
	high_score_label.text = "High Score: " + str(Save.data.high_scores[Controller.game_mode])
	visible = true

func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
