extends CharacterBody2D

var input = Vector2.ZERO

@export var max_speed = 400
@export var acceleration = 1000
@export var friction = 100

var locked_rotation = false

@export var floor_boundary : Sprite2D

func _physics_process(delta):
	movement_actions(delta)
	
func movement_actions(delta):
	
	input.x = int(Input.is_action_pressed("move_right"))
	input.x = input.x - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down"))
	input.y = input.y - int(Input.is_action_pressed("move_up"))
	input = input.normalized()
	
	if input == Vector2.ZERO:
		# Add friction to velocity in cycles with no input
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(max_speed)
	
	if input != Vector2.ZERO:
		$AnimatedSprite2D.play("moving")
	else:
		if(not $AnimatedSprite2D.is_playing()):
			$AnimatedSprite2D.play("default")
	
	if not locked_rotation and velocity != Vector2.ZERO:
		rotation = velocity.angle() + PI / 2
		
	move_and_slide()
	position = floor_boundary.limit_to_square(position)

func _on_building_planter_placement_started():
	# Turn and freeze to mouse position 
	# Mouse position rotates building placement
	rotation = global_position \
	.angle_to_point(get_global_mouse_position()) + PI / 2
	locked_rotation = true

func _on_building_planter_placement_ended():
	locked_rotation = false
