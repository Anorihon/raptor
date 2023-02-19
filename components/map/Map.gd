extends Node2D
class_name Map

signal click_cell
signal click_zone_cell

const CELL_SIZE = 128
const HALF_CELL_SIZE = CELL_SIZE / 2

var rng = RandomNumberGenerator.new()
var tiles = []
onready var grid_node = $grid
onready var objects_node = $objects

onready var mountains_tile_index = objects_node.tile_set.find_tile_by_name('mountains')
onready var chalk_tile_index = objects_node.tile_set.find_tile_by_name('chalk')

onready var exit_tile_index = grid_node.tile_set.find_tile_by_name('exit')
onready var grass_tile_index = grid_node.tile_set.find_tile_by_name('grass')
onready var savannah_tile_index = grid_node.tile_set.find_tile_by_name('savannah')

var zones = {
	"main": [],
	"hunters": [],
	"exit": [],
}

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
#	fill_zones()
#	generate_map()
	
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
#	_on_viewport_size_changed()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clicked_cell = grid_node.world_to_map(grid_node.to_local(event.position))
			var grid_tile_index = grid_node.get_cell(clicked_cell.x, clicked_cell.y)
			var obj_tile_index = objects_node.get_cell(clicked_cell.x, clicked_cell.y)
			
			emit_signal(
				"click_cell",
				clicked_cell,
				grid_tile_index,
				obj_tile_index
			)
			
			if obj_tile_index == Global.EMapObj.CHALK:
				emit_signal(
					"click_zone_cell",
					clicked_cell,
					grid_tile_index,
					obj_tile_index
				)


func _on_viewport_size_changed():
	var rect = grid_node.get_used_rect()
	
	position.x = get_viewport_rect().size.x / 2 - rect.size.x * CELL_SIZE / 2


func fill_zones():
	var start_row = 0
	var start_col = 2
	
	# Fill main
	for i in 6:
		var zone = []
		
		for row in 3:
			for col in 3:
				var cell = Vector2(start_col + col, start_row + row)
				
				zone.append(cell)
		
		zones.main.append(zone)
		
		start_col += 3
		if i == 2:
			start_row = 3
			start_col = 2
	
	# Fill Hunters zones
	for i in 2:
		var cells = []
		
		for row in 6:
			cells.append(Vector2(
				1 if i == 0 else 11, 
				row
			))
			
			if row == 2:
				zones.hunters.append(cells)
				cells = []
		
		zones.hunters.append(cells)
	
	# Fill exit zones
	for i in 2:
		for row in 2:
			zones.exit.append(Vector2(
				0 if i == 0 else 12, 
				row + 2
			))

func generate_map():
	tiles = [
		{
			"id": 1,
			"rotate": 0,
			"mounts": [
				[0, 0, 0],
				[0, 1, 0],
				[0, 0, 0],
			],
			"cells": [],
		},
		{
			"id": 2,
			"rotate": 0,
			"mounts": [
				[0, 1, 0],
				[0, 0, 0],
				[0, 0, 0],
			],
			"cells": [],
		},
		{
			"id": 3,
			"rotate": 0,
			"mounts": [
				[0, 1, 0],
				[0, 0, 0],
				[1, 0, 0],
			],
			"cells": [],
		},
		{
			"id": 4,
			"rotate": 0,
			"mounts": [
				[0, 0, 1],
				[0, 0, 0],
				[1, 0, 0],
			],
			"cells": [],
		},
		{
			"id": 5,
			"rotate": 0,
			"mounts": [
				[0, 1, 0],
				[0, 1, 0],
				[0, 0, 0],
			],
			"cells": [],
		},
		{
			"id": 6,
			"rotate": 0,
			"mounts": [
				[1, 0, 0],
				[0, 0, 0],
				[0, 0, 0],
			],
			"cells": [],
		},
	]
	
	for tile in tiles:
		tile.rotate = rng.randi_range(0, 3)
		
		for i in tile.rotate:
			tile.mounts = Global.rotate_array(tile.mounts)
	
	tiles.shuffle()
	
	# Exit zones
	var exitZones = [0, 12]
	for column in exitZones:
		grid_node.set_cell(column, 2, exit_tile_index)
		grid_node.set_cell(column, 3, exit_tile_index)
#		objects_node.set_cell(column, 2, chalk_tile_index)
#		objects_node.set_cell(column, 3, chalk_tile_index)
	
	# Spawn hunters zones
	var huntersColumns = [1, 11]
	
	for column in huntersColumns:
		for i in 6:
			grid_node.set_cell(column, i, savannah_tile_index)
#			objects_node.set_cell(column, i, chalk_tile_index)
	
	# Fill main cells
	var start_col = 2
	var start_row = 0
	
	for i in tiles.size():
		var tile = tiles[i]
		
		if i > 2:
			start_row = 3
		if i == 3:
			start_col = 2
		
		for row in 3:
			for col in 3:
				var isMountains = tile.mounts[row][col]
				
				grid_node.set_cell(start_col + col, start_row + row, grass_tile_index)
				
				if isMountains:
					objects_node.set_cell(
						start_col + col, 
						start_row + row, 
						mountains_tile_index
					)
		
		start_col += 3

func get_cell_position(col, row):
	return grid_node.map_to_world(Vector2(col, row))

func reset_highlight():
	for row in 6:
		for col in 12:
			var cell = objects_node.get_cell(col, row)
			
			if cell == Global.EMapObj.CHALK:
				objects_node.set_cell(col, row, -1)

func highlight_place_zones(zone: int, excluded_zones: Array):
	reset_highlight()
	
	print('highlight_place_zones ', zone, ' ', excluded_zones)
	
	match zone:
		Global.EPlaceZone.TREX:
			var cells = zones.main[1] + zones.main[4]
			
			for cell in cells:
				var hasObj = objects_node.get_cell(cell.x, cell.y)
				
				if hasObj == -1:
					objects_node.set_cell(cell.x, cell.y, chalk_tile_index)
		Global.EPlaceZone.RAPTOR:
			for zone_index in zones.main.size():
				var is_excluded = excluded_zones.find(zone_index)
				
				if is_excluded >= 0:
					continue
				
				var cells = zones.main[zone_index]
				
				for cell in cells:
					var has_mounties = objects_node.get_cell(cell.x, cell.y)
					
					if has_mounties == -1:
						objects_node.set_cell(cell.x, cell.y, chalk_tile_index)
		Global.EPlaceZone.HUNTER:
			for zone_index in zones.hunters.size():
				var is_excluded = excluded_zones.find(zone_index)

				if is_excluded >= 0:
					continue

				var cells = zones.hunters[zone_index]
				
				for cell in cells:
					objects_node.set_cell(cell.x, cell.y, chalk_tile_index)

func get_cells(pos: Vector2):
	var start_row = 0
	var start_col = 2
	
	for row in 6:
		for col in 9:
			pass
