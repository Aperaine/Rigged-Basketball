extends Node2D

var score:int = 0
@export var active:bool = false

@onready var touch_screen: Control = $"Overlay/Touch screen"
@onready var score_label: Label = $"GUI/Score Label"



func _ready() -> void:
	active = true
	
	score_label.text = str(score)
	touch_screen.modulate.a = Config.get_config(AppSettings.INPUT_SECTION,"TouchButtonsOpacity", 3) / 7


## Add an amount to the score
func addScore(amount:int = 1):
	if active:
		score += amount
		print("Score: ", score)
		score_label.text = str(score)

func gameOver():
	print("Game Over")
	active = false
	$Thrower.active = false
