extends CharacterBody2D

@export var moveSpeed:float = 300
var moveAcceleration:float = 600

@export var maxPositionX = 588
@export var minPositionX = 52

func _physics_process(delta: float) -> void:
	move(delta)
	

func move(delta:float):
	var movement = Input.get_axis("moveLeft","moveRight")
	velocity.x = move_toward(velocity.x, movement * moveSpeed, moveAcceleration * delta)
	
	if position.x >= maxPositionX:
		position.x = maxPositionX
	elif position.x <= minPositionX:
		position.x = minPositionX
	
	move_and_slide()
