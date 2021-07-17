extends Panel


var taskData

onready var i = $LineEdit.get_line_count()

func taskInit(data):
	taskData = data
	$LineEdit.text = taskData.taskName
	rect_min_size.y = taskData.sizeY
#	taskData.currentParentBoard = boardData
#	$LineEdit.text = taskData.taskName
	


func setPath(path):
	taskData.currentPath = path

func addMilestone():
	pass


func milestoneCompleted():
	pass


func milestonesFinished():
	pass


func _on_Delete_pressed():
	get_tree().call_group("BoardGroup", "deleteTask", taskData)
#	taskData.currentParentBoard.tasks.erase(taskData)
	queue_free()


func _on_Option_pressed():
#	var pos = $Option.rect_global_position
#	get_tree().call_group("MainGroup", "showMilestonePanel", pos, taskData)
	pass


# -------------------------------------------
func get_drag_data(position):
	return taskData
# -------------------------------------------



func _on_LineEdit_text_changed():
	taskData.taskName = $LineEdit.text
	if i < $LineEdit.get_line_count():
		i = $LineEdit.get_line_count()
		rect_min_size.y += 30
		taskData.sizeY = rect_min_size.y
	elif i > $LineEdit.get_line_count():
		i = $LineEdit.get_line_count()
		rect_min_size.y -= 30
		taskData.sizeY = rect_min_size.y
