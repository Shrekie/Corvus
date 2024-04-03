extends StaticBody2D

func disable_building_structure():
	set_collision_layer_value(1, false)
	$TurretStructure.turret_spender.disable_cone_detection()
	$Lifeforce.damagble = false

func enable_building_structure():
	set_collision_layer_value(1, true)
	$TurretStructure.turret_spender.enable_cone_detection()
	$Lifeforce.damagble = true

func _on_cone_damager_damage_dealt():
	$AnimatedSprite2D.play("fire")

func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D)

func _on_lifeforce_host_death():
	$ConeDamager.disable_cone_detection()
	queue_free()
