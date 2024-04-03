extends RigidBody2D

func _on_lifeforce_host_death():
	pass
	#queue_free()
	
func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D)
