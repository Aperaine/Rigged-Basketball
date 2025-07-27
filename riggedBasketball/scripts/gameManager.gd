extends Node2D

var score:int = 0
@export var active:bool = false

func _ready() -> void:
	active = true


## Add an amount to the score
func addScore(amount:int = 1):
	if active:
		score += amount
		print("Score: ", score)

func gameOver():
	print("Game Over")
	active = false
	$Thrower.active = false
