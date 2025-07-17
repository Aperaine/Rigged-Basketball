extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@onready var originalPos:Vector2 = position
@export var target:Vector2
@export var speed:int = 2
var arcHeight:int = 200
var syncProjectile:bool = false

@onready var frozenposition = position
func _physics_process(delta: float) -> void:
	## for testing
	if Input.is_action_just_pressed("moveRight"):
		syncProjectile = true
		projectile.move()
		projectile.launch(originalPos, target, arcHeight, speed)
	
	if Input.is_action_just_pressed("moveLeft"):
		syncProjectile = false
		set_physics_process(true)
	
	if syncProjectile:
		freeze = true
		#position = projectile.position
		#rotation = projectile.rotation
		position = Vector2(0,0)
		print("setting position")
		var frozenposition = position 
		print(frozenposition)
	else:
		print(frozenposition)
		freeze = false
		if frozenposition != originalPos:
			position = frozenposition
		
		print("not setting position")


func _on_body_entered(_body: Node) -> void:
	#print("enter")
	syncProjectile = false
	projectile.stop()
