extends Area2D

@onready var game: Node2D = $".."

func _on_body_entered(body: Node2D) -> void:
	if body.scored:
		body.queue_free()
	else:
		game.gameOver()
