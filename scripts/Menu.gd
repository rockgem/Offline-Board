extends Control

var fileSelected = ""

func _ready():
	var dir = Directory.new()
	
	if dir.open(DataManager.SAVE_PATH) == OK:
		dir.list_dir_begin()
		
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				$ScrollContainer/ItemList.add_item(fileName)
			
			fileName = dir.get_next()



func _on_New_pressed():
	$NewBoardPop.show()


func _on_Create_pressed():
	if $NewBoardPop/LineEdit.text != "":
		var wsn = $NewBoardPop/LineEdit.text
		DataManager.newBoard(wsn)


func _on_ItemList_item_selected(index):
	fileSelected = $ScrollContainer/ItemList.get_item_text(index)
	$Load.disabled = false


func _on_ItemList_nothing_selected():
	fileSelected = ""
	$Load.disabled = true


func _on_Load_pressed():
	if fileSelected != "":
		DataManager.loadBoard(fileSelected)


func _on_Close_pressed():
	$NewBoardPop.hide()
