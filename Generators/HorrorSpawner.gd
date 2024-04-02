extends Node

@export var horror_spawn_scene: PackedScene
@export var soul_to_hunt = Node2D.new()

func _on_spawn_timer_timeout():
	var horror_spawn = horror_spawn_scene.instantiate()
	horror_spawn.position.y = -500
	horror_spawn.position.x = randi_range(-200, 200)
	horror_spawn.get_node("SoulHuntingAttraction").soul_to_hunt = soul_to_hunt
	add_sibling(horror_spawn)
	#horror_spawn.move_and_collide(horror_spawn.position, true) == null
