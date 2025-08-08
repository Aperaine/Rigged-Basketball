extends StaticBody2D

@onready var game: Node2D = $".."

@export var maxSpeed:int = 700
var activeSpeed:float = 0
@export var moveAcceleration:float = 50

@export var maxPositionX = 588
@export var minPositionX = 52

@export var swishSFX : AudioStreamPlayer
var pitchScale := Vector2(1, 2)


func _process(delta: float) -> void:
	
	move(delta)
	

func move(delta:float):
	var movement = Input.get_axis("moveLeft","moveRight")
	activeSpeed = move_toward(activeSpeed, movement * maxSpeed, moveAcceleration)
	
	position.x = clamp(position.x + activeSpeed * delta, minPositionX, maxPositionX)


func _on_hole_body_entered(body: RigidBody2D) -> void:
	game.addScore()
	body.set_collision_layer_value(2,false)
	body.scored = true
	
	swishSFX.pitch_scale = randf_range(pitchScale.x, pitchScale.y)
	swishSFX.play()


func _on_game_game_over_signal() -> void:
	set_process(false)
