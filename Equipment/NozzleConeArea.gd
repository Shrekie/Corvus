@tool
extends Area2D

@export_range(0, 300, 0.5) var cone_width: float = 100:
	set(new_cone_width):
		$CollisionPolygon2D.polygon[0].x = new_cone_width
		$CollisionPolygon2D.polygon[3].x = -new_cone_width
		cone_width = new_cone_width

@export_range(0, 720, 0.5) var cone_height: float = 360:
	set(new_cone_height):
		$CollisionPolygon2D.polygon[0].y = -new_cone_height
		$CollisionPolygon2D.polygon[3].y = -new_cone_height
		cone_height = new_cone_height
		
func _ready():
	if not Engine.is_editor_hint():
		add_nozzle_cone_highlight()
		
func add_nozzle_cone_highlight():
	var polygon_sprite = Polygon2D.new()
	polygon_sprite.color = Color(0.85, 0.85, 0.85, 0.19)
	polygon_sprite.polygon = $CollisionPolygon2D.polygon
	add_child(polygon_sprite)

#Default PackedVector2Array Polygon
#PackedVector2Array(
#[Vector2(100, -360),
#Vector2(10, 0),
#Vector2(-10, 0),
#Vector2(-100, 360)])
