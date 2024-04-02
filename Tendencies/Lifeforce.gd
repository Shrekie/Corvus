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
		else:
			host_damaged.emit()
