extends Node

@export var horror_spawn_scene: PackedScene
@export var soul_to_hunt = Node2D.new()
@export var despawn_notifier = Node.new()
@export var floor_boundary : Sprite2D

func _on_spawn_timer_timeout():
	var horror_spawn = horror_spawn_scene.instantiate()
	
	horror_spawn.position.y = \
	randf_range(floor_boundary.get_rect().position.y,\
	floor_boundary.get_rect().end.y)
	
	horror_spawn.position.x = \
	randf_range(floor_boundary.get_rect().position.x,\
	floor_boundary.get_rect().end.x)
	
	horror_spawn.get_node("SoulHuntingAttraction").soul_to_hunt = soul_to_hunt
	horror_spawn.get_node("Lifeforce").host_death.connect(despawn_notifier._on_horror_died)
	
	add_sibling(horror_spawn)
