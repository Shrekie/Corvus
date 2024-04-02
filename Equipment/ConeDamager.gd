extends Node

@export var cone_area = Area2D.new()
@export var damage_amount = 40
@export var group_to_damage = "horror_killable"

var cone_target = null

signal damage_dealt()
	
func damage_target():
	if (cone_target == null):
		$DamageRateCooldown.stop()
	else:
		damage_dealt.emit()
		cone_target.get_node("Lifeforce").damage_host(damage_amount)
		if (cone_target.is_queued_for_deletion()):
			cone_target = null
			
func find_damage_target():
	for existing_body in cone_area.get_overlapping_bodies():
		if(existing_body.is_in_group(group_to_damage)):
			retarget_to_shortest_distance(existing_body)

func on_body_entered_cone_area(entered_body):
	print(entered_body)
	if(entered_body.is_in_group(group_to_damage)):
		if($DamageRateCooldown.is_stopped()):
			$DamageRateCooldown.start()
		
func on_body_exited_cone_area(exited_body):
	if(exited_body.is_in_group(group_to_damage)):
		if(exited_body == cone_target):
			cone_target = null

func retarget_to_shortest_distance(new_target):
	if cone_target == null:
		cone_target = new_target
		return
		
	var distance_to_new_body = \
	cone_area.global_position.distance_squared_to(new_target.global_position)
	var distance_to_cone_target = \
	cone_area.global_position.distance_squared_to(cone_target.global_position)
	
	if distance_to_new_body < distance_to_cone_target:
		cone_target = new_target

func _on_damage_rate_cooldown_timeout():
	find_damage_target()
	damage_target()
	
func disable_cone_detection():
	cone_area.body_entered.disconnect(on_body_entered_cone_area)
	cone_area.body_exited.disconnect(on_body_exited_cone_area)
	
func enable_cone_detection():
	cone_area.body_entered.connect(on_body_entered_cone_area)
	cone_area.body_exited.connect(on_body_exited_cone_area)
