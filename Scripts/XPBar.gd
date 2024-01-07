extends ProgressBar

@onready var level_label = %LevelLabel

func _update_xp_bar():
	level_label.text = "Level " + str(Save.data.level)
	value = Save.data.xp
	max_value = Save.level_reqs[Save.data.level]

func _ready():
	_update_xp_bar()
