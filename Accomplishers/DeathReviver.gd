extends Node2D

@export var player_life: Node2D
@export var soul_life: Node2D

func _ready():
	hide()
	player_life.get_tree().paused = false
	player_life.get_node("Lifeforce").host_death.connect(_on_death)
	soul_life.get_node("Lifeforce").host_death.connect(_on_death)

func _on_death():
	show()
	rotation = -player_life.rotation
	player_life.get_tree().paused = true

func _on_button_button_up():
	get_tree().reload_current_scene()
