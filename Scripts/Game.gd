class_name Game
extends Control

@export var correct_sound = "res://Audio/confirmation_001.ogg"
@export var incorrect_sound = "res://Audio/error_006.ogg"

var json_as_text = FileAccess.get_file_as_string("res://QuestionList.json")
var question_dict = JSON.parse_string(json_as_text)
var gamemode_words = question_dict[Controller.game_mode]

var score : int = 0
var lives : int = 5
var current_question : int
var current_answer : int
var right_answer_button : int
var question_debounce : bool = false
var got_question_wrong : bool = false
