extends Node2D

var score:int = 0
@export var active:bool = false
@export var gameOverScreen:PackedScene

@onready var touch_screen: Control = $"Overlay/Touch screen"
@onready var score_label: Label = $"GUI/Score Label"

signal missedGoal
signal gameOverSignal

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

func missed():
	emit_signal("missedGoal")
	for child in $Balls.get_children():
		child.on_game_missed_goal()
	print("Missed")
	active = false
	$Thrower.active = false

func gameOver():
	emit_signal("gameOverSignal")
	print("gg")
	$GUI.visible = false
	var instance = gameOverScreen.instantiate()
	instance.update(score)
	$Overlay.add_child(instance)
