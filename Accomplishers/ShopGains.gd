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
	add_point()
	
func _on_point_welfare_timer_timeout():
	add_point()
	
func add_point():
	points += 1
	if points >= 99:
		points = 99
	point_added_blink()
	point_node.text = str(points)

func is_insufficient():
	return points < selected_good.price
	
func point_added_blink():
	point_node.self_modulate = Color(0, 1, 0)
	await get_tree().create_timer(0.3).timeout
	point_node.self_modulate = Color(1, 1, 1)

func point_detracted_blink():
	point_node.self_modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.3).timeout
	point_node.self_modulate = Color(1, 1, 1)
	
func decline_placement():
	point_detracted_blink()

func _on_building_planter_placement_completed():
	point_detracted_blink()
	points -= selected_good.price
	point_node.text = str(points)

