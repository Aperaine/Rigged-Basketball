extends Node2D

var score:int = 0
@export var active:bool = false
@export var gameOverScreen:PackedScene

@onready var touch_screen: Control = $"Overlay/Touch screen"
@onready var score_label: Label = $"GUI/Score Label"

signal missedGoal
signal gameOverSignal

func _ready() -> void:
	push_warning("Remove this before export")
	Config.set_config(&'GameSettings', "high", 0)
	Config.set_config(&'GameSettings', "playername", "�")
	
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
	$GUI.visible = false
	
	var high:int = Config.get_config(&'GameSettings', "high", 0)
	var newHigh:bool = false
	print("high: ", high)
	if score > high:
		print("NEW HIGH SCORE: ", score)
		high = score
		newHigh = true
		Config.set_config(&'GameSettings', "high", high)
	
	var instance = gameOverScreen.instantiate()
	instance.update(score, high, newHigh)
	$Overlay.add_child(instance)
	
