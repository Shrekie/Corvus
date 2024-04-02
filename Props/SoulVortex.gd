extends RigidBody2D

func _on_lifeforce_host_death():
	pass
	#queue_free()
	
func _on_lifeforce_host_damaged():
	await get_tree().create_timer(0.3).timeout
	$AnimatedSprite2D.play("damaged")
