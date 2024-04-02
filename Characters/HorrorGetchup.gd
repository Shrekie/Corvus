extends AnimatableBody2D

func _ready():
	$ConeDamager.enable_cone_detection()

func _on_lifeforce_host_damaged():
	await get_tree().create_timer(0.3).timeout
	if($AnimatedSprite2D.animation != "dying"):
		$AnimatedSprite2D.play("damaged")

func _on_lifeforce_host_death():
	$AnimatedSprite2D.play("dying")
	await $AnimatedSprite2D.animation_finished
	queue_free()
