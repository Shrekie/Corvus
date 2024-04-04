extends RigidBody2D

@export var floor_boundary : Sprite2D

func _physics_process(_delta):
	move_and_collide(Vector2(0,0))
	position = floor_boundary.limit_to_square(position)

func _on_lifeforce_host_death():
	pass
	#queue_free()
	
func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D)
