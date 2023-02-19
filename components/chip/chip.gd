extends Area2D
class_name Chip

onready var sprite_node = $Sprite

# x = col; y = row 
var grid_position: Vector2 = Vector2(-1, -1) setget grid_position_set
var texture: Texture setget texture_set


func grid_position_set(pos: Vector2):
	if grid_position == pos:
		return
	
	grid_position = pos
	
	if pos.x > -1 && pos.y > -1:
		position = Vector2(
			0 + pos.x + Map.HALF_CELL_SIZE, 
			0 + pos.y + Map.HALF_CELL_SIZE
		)

func texture_set(val: Texture):
	texture = val
	yield(self, "ready")
	sprite_node.texture = val


func _on_Chip_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed && event.button_index == BUTTON_LEFT:
		print('Clicked')
