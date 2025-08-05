extends PauseMenu

@export var ScoreLabel : Label

var scoreText : String

func update(score:int):
	if score < 10:
		scoreText = "00" + str(score)
	elif score < 100:
		scoreText = "0" + str(score)
	else:
		scoreText = str(score)
	ScoreLabel.text = scoreText
