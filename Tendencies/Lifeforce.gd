extends Node

@export var host = Node.new()
var health = 100

signal host_damaged()
signal host_death()
	
func damage_host(health_damage):
	if (health > 0):
		health -= health_damage
		if (health <= 0):
			host_death.emit()
			host_damaged.emit()
		else:
			host_damaged.emit()
	else:
		host_damaged.emit()

func modulate_damage_color(modulating: CanvasItem, default_modulate: Color):
	if(modulating != null):
		modulating.self_modulate = Color(0.906, 0.812, 0.812)
	await get_tree().create_timer(0.3).timeout
	if(modulating != null):
		modulating.self_modulate = default_modulate
