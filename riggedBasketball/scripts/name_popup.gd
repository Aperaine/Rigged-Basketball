extends Window

signal playerNameSubmitted(name:String)

@export var lineedit:LineEdit
@export var score:int

func submit(name:String):
	if !checkIsFilled():
		return
	
	emit_signal("playerNameSubmitted",name)


func _on_button_pressed() -> void:
	submit(lineedit.text)

func checkIsFilled():
	if lineedit.text == "":
		return(false)
	else:
		return(true)
