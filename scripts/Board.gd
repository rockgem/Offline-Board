extends Panel

var boardName = ""
var boardData

onready var taskPanel = load("res://actors/Task.tscn")

func _ready():
	$ScrollContainer.connect("transferTask", self, "taskTransfered")


func boardInit(data):
	boardData = data
	$BoardName.text = data.boardName
	
	if DataManager.fromLoad:
		fromLoadInit()


func _on_BoardName_text_changed(new_text):
	boardData.boardName = new_text


func _on_Add_pressed():
	var task = taskPanel.instance()
	var taskData = load("res://resources/data/Task.tres").duplicate()
#	var i = DataManager.saveFile.boards.find(boardData)
	
	task.taskInit(taskData)
	boardData.tasks.append(taskData)
	
	$ScrollContainer/GridContainer.add_child(task)
	taskData.currentPath = task.get_path()
	
#	DataManager.saveFile.boards[i].tasks.append(taskData)


func taskTransfered(data):
	var task = taskPanel.instance()
	# tracks the task's previous board owner then erases the taskData in the tasks array in there.
	#data.currentParentBoard.tasks.erase(data)
	
	for i in DataManager.saveFile.boards.size():
#		var j = DataManager.saveFile.boards[i].tasks.find(data)
		DataManager.saveFile.boards[i].tasks.erase(data)
	
	task.taskInit(data)
	
	$ScrollContainer/GridContainer.add_child(task)
	
	var node = get_node(data.currentPath)
	node.queue_free()
	data.currentPath = task.get_path()
	boardData.tasks.append(data)
	
	print(boardData.tasks)


func can_drop_data(position, data):
	return false


func _on_Delete_pressed():
	DataManager.saveFile.boards.erase(boardData)
	queue_free()


func fromLoadInit():
	for i in boardData.tasks.size():
		var task = load("res://actors/Task.tscn").instance()
		task.taskInit(boardData.tasks[i])
		$ScrollContainer/GridContainer.add_child(task)
		boardData.tasks[i].currentPath = task.get_path()
	


func deleteTask(taskData):
	var j = DataManager.saveFile.boards.find(boardData)
#	var i = DataManager.saveFile.boards[j].tasks.find(taskData)
#	if i != -1:
	DataManager.saveFile.boards[j].tasks.erase(taskData)
