extends Node

var level_reqs = [
	100, 110, 120, 140, 160, 190, 220, 260, 300, 350, 400, 460, 520, 590, 660, 740, 820, 910, 1000
]

const SAVE_FILE = "user://save_file3.save"
var data = {}

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(data)
	
func load_data():
	if FileAccess.file_exists(SAVE_FILE):
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		data = file.get_var()
	else:
		print("creating new data")
		data = {
			"level" = 1,
			"xp" = 0,
			high_scores = {
				"Vowel Identification" = 0,
				"Consonant Identification" = 0,
				"Word Match" = 0
			}
		}
		save_data()
