extends Node2D

@export var active:bool

@export_category("Locations")
@export var targetBoundaryL:Vector2 = Vector2(40,150)
@export var targetBoundaryR:Vector2 = Vector2(600,200)
@export var throwBoundaryL:int = 20
@export var throwBoundaryR:int = 620
var target:Vector2

var rng = RandomNumberGenerator.new()

@export_category("Timers")
@export var startingDelay: int = 2
@export var timeBetweenThrows:float = 3
@export var minimumTimeBetweenThrows:int = 1

const ballScene = preload("res://scenes/ball.tscn")
@onready var ballsCollection: Node = $"../Balls"
var ballCount:int = 0

var ballSpeed = 3

func _ready() -> void:
	active = true
	rng.randomize()
	
	await get_tree().create_timer(startingDelay).timeout
	while active:
		throw()
		
		if ballCount % 2 == 0:
			ballSpeed += 0.1
			print("Ball speed: ", ballSpeed)
			
			if timeBetweenThrows > minimumTimeBetweenThrows:
				timeBetweenThrows -= 0.1
				print("Time between throws: ", timeBetweenThrows)
		
		await get_tree().create_timer(timeBetweenThrows).timeout

func throw() -> void:
	ballCount += 1
	
	target.x = rng.randf_range(targetBoundaryL.x, targetBoundaryR.x)
	target.y = rng.randf_range(targetBoundaryL.y, targetBoundaryR.y)
	
	position.x = rng.randf_range(throwBoundaryL, throwBoundaryR)
	
	var ball = ballScene.instantiate()
	ball.target = target
	ball.position = position
	ball.originalPos = position
	ball.speed = ballSpeed
	ballsCollection.add_child(ball)
