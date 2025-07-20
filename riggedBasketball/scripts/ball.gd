extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@onready var originalPos:Vector2 = position
@export var target:Vector2
@export var speed:int
var arcHeight:int = 300
var syncProjectile:bool = false

var firstTimer: bool = true

var yBeforePos:float
var yAfterPos:float

func _ready() -> void:
	freeze = true
	speed = round(abs(originalPos.x-target.x)/220 + 2)
	projectile.launch(originalPos,target,arcHeight,speed)
	syncProjectile = true


func _physics_process(_delta: float) -> void:
	if syncProjectile:
		projectileSync()
		
		if yBeforePos < yAfterPos:
			physicsRelease()

func projectileSync() -> void:
	yBeforePos = global_position.y
	global_position = projectile.position
	global_rotation = projectile.rotation
	yAfterPos = global_position.y

func physicsRelease():
	$CollisionShape2D.disabled = false
	syncProjectile = false
	projectile.stop()
	freeze = false
	
	linear_velocity.x = (target.x - originalPos.x)/1.4
	
	set_physics_process(false)
