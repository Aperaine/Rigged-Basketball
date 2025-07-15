extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@onready var originalPos:Vector2 = position
@export var target:Vector2
@export var speed:int = 2
var arcHeight:int = 200
var syncProjectile:bool = false


func _physics_process(delta: float) -> void:
	## for testing
	if Input.is_action_just_pressed("moveRight"):
		syncProjectile = true
		projectile.launch(originalPos, target, arcHeight, speed)
	
	if syncProjectile:
		projectile._physics_process(delta)
		
		position = projectile.position
		rotation = projectile.rotation
	


func _on_body_entered(_body: Node) -> void:
	print("enter")
	syncProjectile = false
