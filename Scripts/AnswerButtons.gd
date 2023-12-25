extends VBoxContainer

signal answer_button_pressed(choice)

@export var button_template : PackedScene

@export var buttons : Array
@export var normal_button_texture : StyleBoxTexture
@export var correct_button_texture : StyleBoxTexture
@export var incorrect_button_texture : StyleBoxTexture

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
	visible = true
	for i in range(buttons.size()):
		get_node(buttons[i]).text = str(button_texts[i])
		_update_button_style(get_node(buttons[i]), normal_button_texture)

func _update_button_style(button, texture):
	button.remove_theme_stylebox_override("normal")
	button.remove_theme_stylebox_override("hover")
	button.remove_theme_stylebox_override("pressed")
	print(button.get_draw_mode())
	button.add_theme_stylebox_override("normal", texture)
	button.add_theme_stylebox_override("hover", texture)
	button.add_theme_stylebox_override("pressed", texture)
	button.add_theme_stylebox_override("focus", texture)
	button.add_theme_stylebox_override("disabled", texture)

func show_answer(answer_picked, right_answer):
	_update_button_style(get_node(buttons[answer_picked]), incorrect_button_texture)
	_update_button_style(get_node(buttons[right_answer]), correct_button_texture)
