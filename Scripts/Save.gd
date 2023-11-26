extends Node

const SAVE_FILE = "user://save_file1.save"
var data = {}

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(data)
	
func load_data():
	if FileAccess.file_exists(SAVE_FILE):
		print("save found")
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		data = file.get_var()
		print(data.high_score)
	else:
		print("making new save")
		data = {
			"high_score" = 0
		}
		print(data.high_score)
