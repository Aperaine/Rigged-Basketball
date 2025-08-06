extends PauseMenu

@export var TitleLabel : RichTextLabel
@export var ScoreLabel : Label
@export var HighLabel : Label
@export var PosLabel : Label
var scoreText : String


func update(score:int, high:int, newHigh:bool):
	ScoreLabel.text = returnStringWithZeroes(score)
	HighLabel.text = returnStringWithZeroes(high)
	
	match newHigh:
		false:
			TitleLabel.text = "Game Over"
		
		true:
			TitleLabel.text = "[wave amp=50 freq=20][pulse color=yellow]NEW BEST"
	

func returnStringWithZeroes(num:int):
	if num < 10:
		return( "00" + str(num) )
	elif num < 100:
		return( "0" + str(num) )
	else:
		return ( str(num) )
