extends Node2D

@export var player_life: Node2D
@export var soul_life: Node2D
@export var scenario_to_reload: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelContainer.hide()
	player_life.get_tree().paused = false
	player_life.get_node("Lifeforce").host_death.connect(_on_death)
	soul_life.get_node("Lifeforce").host_death.connect(_on_death)
	
func _process(_delta):
	$PanelContainer.rotation = -player_life.rotation

func _on_death():
	$PanelContainer.show()
	player_life.get_tree().paused = true

func _on_button_button_up():
	scenario_to_reload.get_tree().reload_current_scene()

