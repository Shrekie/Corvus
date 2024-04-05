extends Node

@onready var lifeforce = get_parent().get_node("Lifeforce")
@export var modulator: Node2D

func _on_timer_timeout():
	if(lifeforce.health < 100):
		lifeforce.health += 5
		if lifeforce.health > 100:
			lifeforce.health = 100
			
		lifeforce.size_healthbar()
		lifeforce.modulate_heal_color(modulator)
