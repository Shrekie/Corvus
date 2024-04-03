extends Sprite2D

func limit_to_square(position_area):
	return position_area.clamp(get_rect().position, get_rect().end)
