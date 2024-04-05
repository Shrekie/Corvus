extends Node2D

var life_points = 0
@export var player_life: Node2D

func _process(_delta):
	rotation = -player_life.rotation

func _on_life_score_timer_timeout():
	life_points += 1
	$LifeScorePanel.text = str(life_points)
