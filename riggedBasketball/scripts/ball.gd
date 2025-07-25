extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@export var originalPos:Vector2
@export var target:Vector2
@export var scored:bool = false
@export var speed:float = 3
var arcHeight:int = 500
var syncProjectile:bool = false

var firstTime: bool = true

var yBeforePos:float
var yAfterPos:float

func _ready() -> void:
	freeze = true
	z_index = 1
	$Sprite.rotation_degrees = round(randf_range(0,360))
	
	speed = abs(originalPos.x-target.x)/220 + speed
	projectile.launch(originalPos,target,arcHeight,speed)
	syncProjectile = true
	visible = true


func _physics_process(_delta: float) -> void:
	if syncProjectile:
		projectileSync()
		
		if yBeforePos < yAfterPos && !firstTime:
			physicsRelease()
		else:
			firstTime = false

func projectileSync() -> void:
	yBeforePos = global_position.y
	global_position = projectile.position
	global_rotation = projectile.rotation
	yAfterPos = global_position.y

## To release the ball from the projectile's movement and unfreeze physics
func physicsRelease():
	$CollisionShape2D.disabled = false
	syncProjectile = false
	projectile.stop()
	freeze = false
	
	linear_velocity.x = (target.x - originalPos.x)/1.4
	
	set_physics_process(false)
	z_index = -1
