extends VBoxContainer

signal answer_button_pressed(choice)

@export var buttons : Array
@export var normal_button_texture : Texture2D
@export var correct_button_texture : Texture2D
@export var incorrect_button_texture : Texture2D

func _on_button_1_pressed():
	answer_button_pressed.emit(0)
func _on_button_2_pressed():
	answer_button_pressed.emit(1)
func _on_button_3_pressed():
	answer_button_pressed.emit(2)
func _on_button_4_pressed():
	answer_button_pressed.emit(3)

func _update_button_texts(button_texts):
	for i in range(buttons.size()):
		get_node(buttons[i]).get_node("Label").text = str(button_texts[i])
		get_node(buttons[i]).texture_normal = normal_button_texture


func show_answer(answer_picked, right_answer):
	get_node(buttons[answer_picked]).texture_normal = incorrect_button_texture
	get_node(buttons[right_answer]).texture_normal = correct_button_texture
