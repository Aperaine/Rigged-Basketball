extends StaticBody2D

@onready var game: Node2D = $".."

@export var maxSpeed:int = 500
var activeSpeed:float = 0
@export var moveAcceleration:float = 20

@export var maxPositionX = 588
@export var minPositionX = 52

func _process(delta: float) -> void:
	if game.active:
		move(delta)
	

func move(delta:float):
	var movement = Input.get_axis("moveLeft","moveRight")
	activeSpeed = move_toward(activeSpeed, movement * maxSpeed, moveAcceleration)
	
	position.x += activeSpeed * delta
	
	if position.x >= maxPositionX:
		position.x = maxPositionX
		activeSpeed = 0
	elif position.x <= minPositionX:
		position.x = minPositionX
		activeSpeed = 0


func _on_hole_body_entered(body: RigidBody2D) -> void:
	game.addScore()
	body.set_collision_layer_value(2,false)
	body.scored = true
