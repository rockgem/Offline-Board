extends Panel

var currentTaskData

func initMilestone(data):
	currentTaskData = data
	displayMilestones()


func displayMilestones():
	print(currentTaskData.milestones)
	
	for i in currentTaskData.milestones.size() - 1:
		var milestone = load("res://actors/Milestone.tscn").instance()
		var data = currentTaskData.milestones[i]
		
		milestone.initMilestone(data)
		
		$ScrollContainer/GridContainer.add_child(milestone)


func _on_Add_pressed():
	var milestone = load("res://actors/Milestone.tscn").instance()
	var data = load("res://resources/data/Milestone.tres").duplicate()
	
	milestone.initMilestone(data)
	
	$ScrollContainer/GridContainer.add_child(milestone)
	currentTaskData.milestones.append(data)


func _on_Close_pressed():
	for i in $ScrollContainer/GridContainer.get_child_count() - 1:
		$ScrollContainer/GridContainer.get_child(i).queue_free()
	
	hide()
