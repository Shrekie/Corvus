extends Node2D

var game_scenario = preload("res://Scenarios/PlayerGrounds.tscn")
var button_clicks = 0

func _on_button_button_up():
	button_clicks += 1
	$AnimatedSprite2D.frame = button_clicks
	if(button_clicks >= 6):
		get_tree().change_scene_to_packed(game_scenario)
