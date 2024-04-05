extends Node

@export var host = Node.new()
var health = 100
@export var damagble = true

signal host_damaged()
signal host_death()
	
func damage_host(health_damage):
	if (damagble):
		if (health > 0):
			health -= health_damage
			size_healthbar()
			if (health <= 0):
				health = 0
				size_healthbar()
				host_death.emit()
				host_damaged.emit()
			else:
				host_damaged.emit()
		else:
			host_damaged.emit()
			
func size_healthbar():
	$HealthBar.polygon[2].x = health
	$HealthBar.polygon[3].x = health

## Blinks canvas item as if taking damage
func modulate_damage_color(modulating: CanvasItem):
	if(modulating != null):
		modulating.self_modulate = Color(1, 0.8, 0.8)
	await get_tree().create_timer(0.3).timeout
	if(modulating != null):
		modulating.self_modulate = Color(1, 1, 1)
		
## Blinks canvas item as if healing
func modulate_heal_color(modulating: CanvasItem):
	if(modulating != null):
		modulating.self_modulate = Color(0.8, 1, 0.8)
	await get_tree().create_timer(0.3).timeout
	if(modulating != null):
		modulating.self_modulate = Color(1, 1, 1)
