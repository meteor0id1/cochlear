extends Control

signal update_button_texts(button_texts : Array)
signal show_answer(answer_picked, right_answer)
signal update_score(score : int)
signal update_lives(lives : int)

@onready var question_label = %QuestionLabel
@onready var question_end_timer = $QuestionEndTimer

var file = "res://QuestionList.json"
var json_as_text = FileAccess.get_file_as_string(file)
var question_dict = JSON.parse_string(json_as_text)

var score : int = 0
var lives : int = 5
var current_question : int
var right_answer_button : int
var question_debounce : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score.emit(score)
	pick_new_question()

func pick_new_question():
	current_question = randi() % question_dict.size()
	var question_data = question_dict[current_question]
	question_label.text = question_data.question
	
	var button_texts = []
	for i in range(4):
		button_texts.append(question_data.options[randi() % 4])
		var is_unique = false
		
		while not is_unique:
			var failed = false
			for j in range(button_texts.size()):
				if i != j and str(button_texts[i]) == str(button_texts[j]):
					button_texts[i] = question_data.options[randi() % 4]
					failed = true
				else:
					is_unique = true
			
			if failed:
				is_unique = false
	
	right_answer_button = randi() % 4
	button_texts[right_answer_button] = question_data.answer
	
	update_button_texts.emit(button_texts)

func on_question_answered(choice):
	if not question_debounce:
		if choice == right_answer_button:
			print("correct")
			score += 10
			update_score.emit(score)
		else:
			print("incorrect")
			lives -= 1
			update_lives.emit(lives)
		
		question_debounce = true
		question_end_timer.start()
		show_answer.emit(choice, right_answer_button)

func _on_question_end_timer_timeout():
	question_debounce = false
	pick_new_question()
