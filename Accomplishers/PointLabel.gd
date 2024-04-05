extends Label

@export var counter_rotator: Node2D

func _process(_delta):
	rotation = -counter_rotator.rotation
