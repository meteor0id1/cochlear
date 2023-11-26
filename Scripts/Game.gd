extends Control

signal update_button_texts(button_texts : Array)
signal show_answer(answer_picked, right_answer)
signal update_score(score : int)
signal update_lives(lives : int)
signal game_over(final_score : int)
signal play_sound(name : String)

@export var correct_sound = "res://Audio/confirmation_001.ogg"
@export var incorrect_sound = "res://Audio/error_006.ogg"

@onready var question_label = %QuestionLabel
@onready var question_end_timer = $QuestionEndTimer
@onready var game_over_panel = %GameOverPanel


var file = "res://QuestionList.json"
var json_as_text = FileAccess.get_file_as_string(file)
var question_dict = JSON.parse_string(json_as_text)

var score : int = 0
var lives : int = 5
var current_question : int
var current_answer : int
var right_answer_button : int
var question_debounce : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score.emit(score)
	pick_new_question()

func pick_new_question():
	current_question = randi() % question_dict.size()
	var question_data = question_dict[current_question]
	current_answer = randi() % question_data.options.size()
	question_label.text = str(current_question)
	
	var button_texts = []
	for i in range(4):
		button_texts.append(question_data.options[randi() % question_data.options.size()])
		var is_unique = false
		is_unique = check_if_unique(question_data, button_texts, i)
		
		while not is_unique:
			button_texts[i] = question_data.options[randi() % question_data.options.size()]
			is_unique = check_if_unique(question_data, button_texts, i)
	
	right_answer_button = randi() % 4
	button_texts[right_answer_button] = question_data.options[current_answer]
	
	update_button_texts.emit(button_texts)

func check_if_unique(question_data, button_texts, i):
	print(button_texts)
	print("testing: " + button_texts[i])
	
	if str(button_texts[i]) == question_data.options[current_answer]:
			print("failed on is answer")
			return false
	
	for j in range(button_texts.size()):
		if i != j and str(button_texts[i]) == str(button_texts[j]):
			print("failed on exists already")
			return false
	
	return true

func on_question_answered(choice):
	if not question_debounce:
		if choice == right_answer_button:
			score += 10
			play_sound.emit("Correct")
			update_score.emit(score)
		else:
			lives -= 1
			play_sound.emit("Incorrect")
			update_lives.emit(lives)
		
		question_debounce = true
		question_end_timer.start()
		show_answer.emit(choice, right_answer_button)

func _on_question_end_timer_timeout():
	question_debounce = false
	if lives <= 0:
		game_over.emit(score)
	else:
		pick_new_question()

