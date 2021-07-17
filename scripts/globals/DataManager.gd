extends Node
# SIGNLETON ------------------ !!

const SAVE_PATH = "user://OfflineBoard/saves"
var saveFile
var workspaceName

var fromLoad = false

func loadBoard(fileName):
	var name = fileName
	var file = File.new()
	var string = "user://OfflineBoard/saves/%s" % name 
	if file.file_exists(string):
		print("file found!")
		saveFile = Savefile.new()
		saveFile = ResourceLoader.load(string)
		
		fromLoad = true
		get_tree().change_scene("res://scenes/Main.tscn")
	else:
		print("save file not found!")
	
	print(string)


func saveBoard():
	var file = File.new()
	var dir = Directory.new()
	
	if dir.dir_exists(SAVE_PATH):
		print("ok")
	else:
		dir.make_dir_recursive(SAVE_PATH)
	
	if file.file_exists(SAVE_PATH + "/%s" % saveFile.workspaceName + ".tres"):
		ResourceSaver.save(SAVE_PATH + "/%s" % saveFile.workspaceName + ".tres" , saveFile)
	else:
		ResourceSaver.save(SAVE_PATH + "/%s" % saveFile.workspaceName + ".tres" , saveFile)
	
	


func newBoard(wsn):
	workspaceName = wsn
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1, 9999999999)
	
	saveFile = Savefile.new()
	saveFile.savefileID = num
	saveFile.workspaceName = workspaceName
	
	saveBoard()
	
	get_tree().change_scene("res://scenes/Main.tscn")
