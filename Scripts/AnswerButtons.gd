extends VBoxContainer

signal answer_button_pressed(choice)

@export var button_template : PackedScene

@export var buttons : Array
@export var normal_button_texture : Texture2D
@export var correct_button_texture : Texture2D
@export var incorrect_button_texture : Texture2D

func _ready():
	buttons.clear()
	for i in range(Controller.difficulty):
		var new_button = button_template.instantiate()
		add_child(new_button)
		new_button.name = "Button" + str(i + 1)
		var function_to_connect = ""
		new_button.pressed.connect(_on_answer_button_pressed.bind(i))
		buttons.append(new_button.get_path())

func _on_answer_button_pressed(button_number):
	answer_button_pressed.emit(button_number)

func _update_button_texts(button_texts):
	for i in range(buttons.size()):
		get_node(buttons[i]).get_node("Label").text = str(button_texts[i])
		get_node(buttons[i]).texture_normal = normal_button_texture


func show_answer(answer_picked, right_answer):
	get_node(buttons[answer_picked]).texture_normal = incorrect_button_texture
	get_node(buttons[right_answer]).texture_normal = correct_button_texture
