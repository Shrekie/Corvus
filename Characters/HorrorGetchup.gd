extends AnimatableBody2D

func _ready():
	$ConeDamager.enable_cone_detection()
	$AnimatedSprite2D.play("moving")

func _on_lifeforce_host_damaged():
	$Lifeforce.modulate_damage_color($AnimatedSprite2D)

func _on_lifeforce_host_death():
	$ConeDamager.disable_cone_detection()
	$AnimatedSprite2D.play("dying")
	await $AnimatedSprite2D.animation_finished
	queue_free()
