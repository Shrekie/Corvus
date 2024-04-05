extends Node

## Character constructing the building
@export var placer_node = CharacterBody2D.new()

## Menu controlling selectable buildings
@export var building_menu : Node

# Currently selected building
var selected_building_scene : PackedScene
var selected_building_placement = Node2D.new()

signal placement_started()
signal placement_completed()
signal placement_canceled()
signal placement_ended()

var is_placing = false

func _ready():
	selected_building_scene = building_menu.selected_good.item

func _process(_delta):
	placing_building()
	
func placing_building():
	
	if is_placing:
		rotate_placement_to_mouse()
		display_inhabited_placement()
		
	if (Input.is_action_just_pressed("build") and not is_placing \
	and building_menu.is_insufficient()):
		building_menu.decline_placement()
		
	elif (Input.is_action_just_pressed("build") and not is_placing):
		place_building()

	elif (Input.is_action_just_pressed("build") and is_placing \
	and not selected_building_colliding()):
		erect_building()
		
	elif (Input.is_action_just_pressed("cancel_build") and is_placing):
		cancel_building()

func erect_building():
	selected_building_placement.get_node("AnimatedSprite2D") \
	.animation = "default"
	
	selected_building_placement.position = \
	get_global_front_placement_spacing()
	
	# Add the parent placer rotation before adding to global sibling scene 
	# to negate nested child rotation 
	selected_building_placement.rotation = \
	 selected_building_placement.rotation + placer_node.rotation
	
	# Remove as child before adding to global scene
	placer_node.remove_child(selected_building_placement)
	
	# Selected building is placed and added as a free standing 
	# decoupled global sibling relative
	selected_building_placement.enable_building_structure()
	placer_node.add_sibling(selected_building_placement)
	
	is_placing = false
	placement_completed.emit()
	placement_ended.emit()

func place_building():
	selected_building_placement = selected_building_scene.instantiate()
	
	selected_building_placement.get_node("AnimatedSprite2D") \
	.animation = "placing"
	
	selected_building_placement.position = \
	get_local_front_placement_spacing()
	
	# Selected building lives as child of the placer node
	# and moves with the placer node until "build" is pressed
	# again and the selected building is added 
	# as a free standing decoupled sibling relative
	placer_node.add_child(selected_building_placement)
	
	is_placing = true
	placement_started.emit()

func cancel_building():
	placer_node.remove_child(selected_building_placement)
		
	is_placing = false
	placement_canceled.emit()
	placement_ended.emit()

func rotate_placement_to_mouse():
	# Angle from selected building to mouse minus the added
	# rotation of the parent placer node
	var placement_to_mouse_angle = \
	selected_building_placement.global_position \
	.angle_to_point(placer_node.get_global_mouse_position()) \
	+ PI / 2 - placer_node.rotation

	selected_building_placement.rotation = placement_to_mouse_angle

func display_inhabited_placement():
	# When placing building on another, the inhabited aleady
	# animation is played
	if(selected_building_colliding()):
		selected_building_placement.get_node("AnimatedSprite2D") \
		.animation = "placing_inhabited"
	else:
		selected_building_placement.get_node("AnimatedSprite2D") \
		.animation = "placing"

func selected_building_colliding():
	var collision_test
	if(selected_building_placement.is_inside_tree()):
		collision_test = \
		selected_building_placement.move_and_collide(Vector2(0,0), true)
		
	if collision_test == null:
		return false
	else:
		return true

# TODO: Dynamic spacing offset based on building size
## The LOCAL positioned spacing between the placer node and a resonable 
## distance in front of the placer node
func get_local_front_placement_spacing():
	var front_placement = placer_node.to_local(placer_node.position)
	front_placement.y -= 150
	return front_placement
	
## The GLOBAL positioned spacing between the placer node and a resonable 
## distance in front of the placer node
func get_global_front_placement_spacing():
	return placer_node.position \
	+ Vector2.from_angle(placer_node.rotation - PI / 2) * 150
