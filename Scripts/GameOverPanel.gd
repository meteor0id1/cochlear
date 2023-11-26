extends ColorRect

@onready var high_score_label = $HighScoreLabel
@onready var final_score_label = $FinalScoreLabel

func _ready():
	pass # Replace with function body.

func _on_game_over(final_score):
	if final_score > Save.data.high_score:
		Save.data.high_score = final_score
		Save.save_data()
	
	final_score_label.text = "Final Score: " + str(final_score)
	high_score_label.text = "High Score: " + str(Save.data.high_score)
	visible = true

func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
