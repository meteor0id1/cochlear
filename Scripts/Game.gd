extends Control

signal update_button_texts(button_texts : Array)
signal show_answer(answer_picked, right_answer)
signal update_score(score : int)
signal update_lives(lives : int)
signal update_incorrect_panel(right_answer : String, wrong_answer : String)
signal game_over(final_score : int)

@export var correct_sound = "res://Audio/confirmation_001.ogg"
@export var incorrect_sound = "res://Audio/error_006.ogg"

@onready var question_label = %QuestionLabel
@onready var question_end_timer = %QuestionEndTimer
@onready var answer_buttons = %AnswerButtons
@onready var game_over_panel = %GameOverPanel
@onready var incorrect_panel = %IncorrectPanel

var json_as_text = FileAccess.get_file_as_string("res://QuestionList.json")
var question_dict = JSON.parse_string(json_as_text)

var score : int = 0
var lives : int = 5
var current_question : int
var current_answer : int
var right_answer_button : int
var question_debounce : bool = false
var got_question_wrong : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score.emit(score)
	pick_new_question()

func pick_new_question():
	if lives <= 0:
		game_over.emit(score)
		return
	
	current_question = randi() % question_dict.size()
	var question_data = question_dict[current_question]
	current_answer = randi() % question_data.options.size()
	
	var button_texts = []
	for i in range(Controller.difficulty):
		button_texts.append(question_data.options[randi() % question_data.options.size()])
		var is_unique = false
		is_unique = check_if_unique(question_data, button_texts, i)
		
		while not is_unique:
			button_texts[i] = question_data.options[randi() % question_data.options.size()]
			is_unique = check_if_unique(question_data, button_texts, i)
	
	right_answer_button = randi() % Controller.difficulty
	button_texts[right_answer_button] = question_data.options[current_answer]
	
	AudioManager.play_word(question_dict[current_question].options[current_answer])
	update_button_texts.emit(button_texts)

func check_if_unique(question_data, button_texts, i):
	if str(button_texts[i]) == question_data.options[current_answer]:
			return false
	
	for j in range(button_texts.size()):
		if i != j and str(button_texts[i]) == str(button_texts[j]):
			return false
	
	return true

func on_question_answered(choice):
	if not question_debounce:
		if choice == right_answer_button:
			score += 10
			AudioManager.play_sound("Correct")
			update_score.emit(score)
		else:
			lives -= 1
			got_question_wrong = true
			update_incorrect_panel.emit(question_dict[current_question].options[current_answer], 
											answer_buttons.get_node("Button" + str(choice + 1)).text)
			AudioManager.play_sound("Incorrect")
			update_lives.emit(lives)
		
		question_debounce = true
		show_answer.emit(choice, right_answer_button)
		question_end_timer.start()

func _on_question_end_timer_timeout():
	question_debounce = false
	if got_question_wrong:
		incorrect_panel.visible = true
		answer_buttons.visible = false
	else:
		pick_new_question()
	
	got_question_wrong = false

func _on_play_word_button_pressed():
	AudioManager.play_word(question_dict[current_question].options[current_answer])
