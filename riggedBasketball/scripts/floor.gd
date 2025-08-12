extends Area2D

@onready var game: Node2D = $".."

func _on_body_entered(body: RigidBody2D) -> void:
	
	body.queue_free()
	game.gameOver()


func _on_out_detector_body_entered(body: RigidBody2D) -> void:
	if !body.scored:
		body.missed()
		game.missed()
