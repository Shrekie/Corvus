extends StaticBody2D

func disable_building_structure():
	$TurretStructure.turret_spender.disable_cone_detection()

func enable_building_structure():
	$TurretStructure.turret_spender.enable_cone_detection()

func _on_cone_damager_damage_dealt():
	$AnimatedSprite2D.play("fire")

func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D)

func _on_lifeforce_host_death():
	$ConeDamager.disable_cone_detection()
	queue_free()
