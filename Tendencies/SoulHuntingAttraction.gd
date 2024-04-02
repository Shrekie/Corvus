extends Node

@export var hunter = AnimatableBody2D.new()
@export var soul_to_hunt = RigidBody2D.new()

signal collided_soul(Node2D)

func _physics_process(delta):
	var angle_vector = hunter.global_position.direction_to(soul_to_hunt.global_position)
	var velocity = angle_vector * 100 * delta
	hunter.rotate(hunter.get_angle_to(soul_to_hunt.global_position) - PI / 2)
	hunter.move_and_collide(velocity)
