extends Node2D

@export var active:bool

@export var targetBoundaryL:Vector2 = Vector2(40,100)
@export var targetBoundaryR:Vector2 = Vector2(600,150)
@export var throwBoundaryL:int = 20
@export var throwBoundaryR:int = 620
var target:Vector2

var rng = RandomNumberGenerator.new()
var timeBetweenThrows:float = 5
var minimumTimeBetweenThrows:int = 2

var ballScene = preload("res://scenes/ball.tscn")
@onready var ballsCollection: Node = $"../Balls"

func _ready() -> void:
	active = true
	rng.randomize()
	throw()

func throw() -> void:
	target.x = rng.randf_range(targetBoundaryL.x, targetBoundaryR.x)
	target.y = rng.randf_range(targetBoundaryL.y, targetBoundaryR.y)
	
	position.x = rng.randf_range(throwBoundaryL, throwBoundaryR)
	
	var ball = ballScene.instantiate()
	ball.target = target
	ball.originalPos = position
	ballsCollection.add_child(ball)
