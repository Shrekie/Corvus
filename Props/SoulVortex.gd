extends RigidBody2D

var default_modulate: Color
	
func _ready():
	default_modulate = $AnimatedSprite2D.get_self_modulate()

func _on_lifeforce_host_death():
	pass
	#queue_free()
	
func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D, default_modulate)
