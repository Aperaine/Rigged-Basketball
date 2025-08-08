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

var failedToScore:bool = false

var pitchScale := Vector2(1, 1.5)
@export var bounceSFX : AudioStreamPlayer


func _ready() -> void:
	freeze = true
	z_index = 1
	$Sprite.rotation_degrees = round(randf_range(0,360))
	
	speed = abs(originalPos.x-target.x)/220 + speed
	projectile.launch(originalPos,target,arcHeight,speed)
	syncProjectile = true
	visible = true
	
	var tween = self.create_tween()
	
	var spriteSize = randf_range(0.15,0.3)
	$Sprite.scale = Vector2(spriteSize, spriteSize)
	tween.tween_property($Sprite, "scale", Vector2(0.1,0.1), 0.7)


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

func missed():
	failedToScore = true
	var tween = self.create_tween()
	tween.tween_property($Sprite, "modulate", Color.RED, 0.1)


func on_game_missed_goal() -> void:
	if !failedToScore:
		set_deferred("freeze", true)
		var tween = self.create_tween()
		tween.set_parallel(true)
		tween.tween_property($Sprite, "scale", Vector2(0,0), 0.3)
		tween.tween_property($Sprite, "modulate", Color.TRANSPARENT, 0.3)
		tween.tween_callback(queue_free)
		


func _on_body_entered(_body: Node) -> void:
	bounceSFX.pitch_scale = randf_range(pitchScale.x, pitchScale.y)
	bounceSFX.play()
