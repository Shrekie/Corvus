extends StaticBody2D

func disable_building_structure():
	$TurretStructure.turret_spender.disable_cone_detection()

func enable_building_structure():
	$TurretStructure.turret_spender.enable_cone_detection()

func _on_cone_damager_damage_dealt():
	$AnimatedSprite2D.play("fire")
