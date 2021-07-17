extends ScrollContainer

signal transferTask


func can_drop_data(position, data):
	return true

func drop_data(position, data):
	emit_signal("transferTask", data)
