extends Game


signal update_button_texts(button_texts : Array)
signal show_answer(answer_picked, right_answer)
signal update_score(score : int)
signal update_lives(lives : int)
signal update_incorrect_panel(right_answer : String, wrong_answer : String)
signal game_over(final_score : int)

@onready var question_label = %QuestionLabel
@onready var question_end_timer = %QuestionEndTimer
@onready var answer_buttons = %AnswerButtons
@onready var game_over_panel = %GameOverPanel
@onready var incorrect_panel = %IncorrectPanel

var words = gamemode_words[str(Controller.difficulty)]

func _ready():
	update_score.emit(score)
	pick_new_question()

func pick_new_question():
	if lives <= 0:
		game_over.emit(score)
		return
	
	current_question = randi() % words.size()
	var question_data = words[current_question]
	current_answer = randi() % question_data.size()
	
	var button_texts = []
	right_answer_button = randi() % 2
	if right_answer_button == 0:
		button_texts.append(question_data[current_answer])
		if current_answer == 0:
			button_texts.append(question_data[current_answer + 1])
		else:
			button_texts.append(question_data[current_answer - 1])
	else:
		if current_answer == 0:
			button_texts.append(question_data[current_answer + 1])
		else:
			button_texts.append(question_data[current_answer - 1])
		button_texts.append(question_data[current_answer])
	
	button_texts[right_answer_button] = question_data[current_answer]
	
	AudioManager.play_word(words[current_question][current_answer])
	update_button_texts.emit(button_texts)

func on_question_answered(choice):
	if not question_debounce:
		if choice == right_answer_button:
			score += Controller.difficulty * 5
			AudioManager.play_sound("Correct")
			update_score.emit(score)
		else:
			lives -= 1
			got_question_wrong = true
			update_incorrect_panel.emit(words[current_question][current_answer], 
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
	AudioManager.play_word(words[current_question][current_answer])
