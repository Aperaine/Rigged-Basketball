extends RigidBody2D

@onready var projectile: ProjectileOnCurve2D = $ProjectileOnCurve2D
@onready var originalPos:Vector2 = position
@export var target:Vector2
@export var speed:int
var arcHeight:int = 300
var syncProjectile:bool = false

var firstTimer: bool = true

func _ready() -> void:
	freeze = true
	speed = round(abs(originalPos.x-target.x)/220 + 2)
	projectile.launch(originalPos,target,arcHeight,speed)
	syncProjectile = true


#func _on_body_entered(body: Node) -> void:
	#print(body.name)

func _physics_process(_delta: float) -> void:
	if syncProjectile:
		projectileSync()
		
		if global_position.y < originalPos.y-arcHeight+20:
			if firstTimer:
				firstTimer = false
				get_tree().create_timer(0.3).timeout.connect(physicsRelease)

func projectileSync() -> void:
	global_position = projectile.position
	global_rotation = projectile.rotation
	

func physicsRelease():
	syncProjectile = false
	projectile.stop()
	freeze = false
	linear_velocity.y = 300
	linear_velocity.x = target.x - originalPos.x
