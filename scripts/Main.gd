extends Control

#onready var board = load("res://actors/Board.tscn").instance()

func _ready():
	if DataManager.fromLoad:
		fromLoadInit()
	
	$WorkspaceName.text = DataManager.saveFile.workspaceName


func _on_AddBoard_pressed():
	var board = load("res://actors/Board.tscn").instance()
	var data = load("res://resources/data/Board.tres").duplicate()
	
	board.boardInit(data)
	DataManager.saveFile.boards.append(data)
	$MainContainer/GridContainer.add_child(board)
	$MainContainer/GridContainer.columns += 1


func showMilestonePanel(pos, data):
	$MilestonePanel.initMilestone(data)
	$MilestonePanel.show()


func can_drop_data(position, data):
	return false


func fromLoadInit():
	for i in DataManager.saveFile.boards.size():
		var board = load("res://actors/Board.tscn").instance()
		$MainContainer/GridContainer.add_child(board)
		board.boardInit(DataManager.saveFile.boards[i])
		$MainContainer/GridContainer.columns += 1
	
	DataManager.fromLoad = false


func _on_Exit_pressed():
	DataManager.saveBoard()
	get_tree().change_scene("res://scenes/Menu.tscn")
