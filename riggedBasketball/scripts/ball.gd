extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@onready var originalPos:Vector2 = position
@export var target:Vector2
@export var speed:int = 4
@export var arcHeight:int = 100
var syncProjectile:bool = false

func _ready() -> void:
	position = target
	freeze = true
	projectile.launch(originalPos,target,arcHeight,speed)
	syncProjectile = true


#func _on_body_entered(body: Node) -> void:
	

func _physics_process(_delta: float) -> void:
	if syncProjectile:
		projectileSync()
	
	if Input.is_action_just_pressed("DEBUG1"):
		physicsRelease()

func projectileSync() -> void:
	global_position = projectile.position
	global_rotation = projectile.rotation

func physicsRelease():
	syncProjectile = false
	projectile.stop()
	freeze = false
