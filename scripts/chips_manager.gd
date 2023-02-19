extends Node2D
class_name Chips

const CHIP_COMPONENT = preload("res://components/chip/chip.tscn")
const TEXTURES = [
	preload("res://assets/img/tyrannosaur.png"),
	preload("res://assets/img/raptor.png"),
	preload("res://assets/img/hunter.png"),
]

func _ready():
	Global.connect("add_chip", self, "add_chip")

func add_chip(chip_type: int, grid_position: Vector2, is_fliped: bool = false):
	assert(chip_type in Global.EChip.values(), "the function argument 'chip_type' is expected to be a EChip value")
	assert(grid_position.x > -1 && grid_position.y > -1, "grid_position is invalid")
	
	var chip = CHIP_COMPONENT.instance()
	
	chip.texture = TEXTURES[chip_type]
	chip.grid_position = grid_position
	chip.add_to_group( Global.EChip.keys()[chip_type].to_lower() )
	
	add_child(chip)
	
	if is_fliped == true:
		chip.scale.x = -chip.scale.x
