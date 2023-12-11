extends PanelContainer

signal play_word(word : String)
signal next_question

@onready var wrong_word_label = $MarginContainer/VBoxContainer/HBoxContainer/WrongWordLabel
@onready var right_word_label = $MarginContainer/VBoxContainer/HBoxContainer/RightWordLabel

var json_as_text = FileAccess.get_file_as_string("res://QuestionList.json")
var question_dict = JSON.parse_string(json_as_text)

func update_panel(right_answer : String, wrong_answer : String):
	right_word_label.text = right_answer
	wrong_word_label.text = wrong_answer

func _on_wrong_word_button_pressed():
	AudioManager.play_word(wrong_word_label.text)

func _on_right_word_button_pressed():
	AudioManager.play_word(right_word_label.text)

func _on_continue_button_pressed():
	visible = false
	next_question.emit()
