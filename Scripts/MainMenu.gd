extends Control



func _on_profile_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Profile.tscn")


func _on_practice_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ModeSelect.tscn")


func _on_test_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Test.tscn")


func _on_extras_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Extras.tscn")
