extends Node

@export var point_node: Control

# All buildings
var precise_gun_turret = {"item": preload("res://Erections/PreciseGunTurret.tscn"), \
"price": 3, "name": "Precise Gun Turret"}

var selected_good = precise_gun_turret

var points = 8

func _ready():
	point_node.text = str(points)

func _on_horror_died():
	points += 1
	if points >= 99:
		points = 99
	point_node.text = str(points)

func is_insufficient():
	return points < selected_good.price
	
func decline_placement():
	point_node.self_modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.3).timeout
	point_node.self_modulate = Color(1, 1, 1)

func _on_building_planter_placement_completed():
	points -= selected_good.price
	point_node.text = str(points)
