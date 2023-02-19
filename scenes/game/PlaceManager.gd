extends Node
class_name PlaceManager

onready var map_node = get_parent().get_node("Map")

const MAX_RAPTORS = 5
const MAX_HUNTERS = 4
var placed_raptors = 0
var placed_hunters = 0
var excluded_zones = []

func _ready():
	Global.connect("game_step_update", self, "_on_game_step_update")
	map_node.connect("click_cell", self, "_on_click_cell")
	
#	_on_game_step_update(Global.EGameSteps.PLACE_TREX)

func _on_PlaceManager_tree_exiting():
	Global.disconnect("game_step_update", self, "_on_game_step_update")
	map_node.disconnect("click_cell", self, "_on_click_cell")

func _on_game_step_update(game_step):
	match Global.game_step:
		Global.EGameSteps.PLACE_TREX:
			map_node.highlight_place_zones(Global.EPlaceZone.TREX, excluded_zones)
		Global.EGameSteps.PLACE_DINO:
			map_node.highlight_place_zones(Global.EPlaceZone.RAPTOR, excluded_zones)
		Global.EGameSteps.PLACE_HUNTERS:
			map_node.highlight_place_zones(Global.EPlaceZone.HUNTERS, excluded_zones)

func _on_click_cell(cell_position, tile_index, obj_index):
	if tile_index == -1 || obj_index != Global.EMapObj.CHALK:
		return
	
	var cell_pos = map_node.get_cell_position(cell_position.x, cell_position.y)
	
#	print(cell_position)
#	print(tile_index)
#	print(obj_index)
	
	# Reset cells
	map_node.reset_highlight()
	
	match Global.game_step:
		Global.EGameSteps.PLACE_TREX:
			# Place TRex
			Global.emit_signal("add_chip", Chips.EChip.TREX, cell_pos)
			
			# Add excluded cells
			excluded_zones.append(1 if cell_position.y <= 2 else 4)
#			map_node.add_excluded_zone(1 if cell_position.y <= 2 else 4)
			
			# Update game step
			Global.game_step = Global.EGameSteps.PLACE_DINO
		Global.EGameSteps.PLACE_DINO:
			placed_raptors += 1
			
			# Place Raptor
			Global.emit_signal("add_chip", Chips.EChip.RAPTOR, cell_pos)
			
			# Exclude zone
			for zone_index in map_node.zones.main.size():
				var found_zone = false
				var cells = map_node.zones.main[zone_index]
				
				for cell in cells:
					if cell.x == cell_position.x && cell.y == cell_position.y:
						excluded_zones.append(zone_index)
						found_zone = true
						break
				
				if found_zone == true:
					break
			
			# Update Game Step
			if placed_raptors < MAX_RAPTORS:
				_on_game_step_update(Global.EGameSteps.PLACE_DINO)
			else:
				excluded_zones = []
				Global.game_step = Global.EGameSteps.PLACE_HUNTERS
		Global.EGameSteps.PLACE_HUNTERS:
			placed_hunters += 1
			
			# Place Hunter
			Global.emit_signal(
				"add_chip", 
				Chips.EChip.HUNTER, 
				cell_pos, 
				true if cell_position.x == 11 else false
			)
			
			# Exclude zone
			for zone_index in map_node.zones.hunters.size():
				var found_zone = false
				var cells = map_node.zones.hunters[zone_index]
				
				for cell in cells:
					if cell.x == cell_position.x && cell.y == cell_position.y:
						excluded_zones.append(zone_index)
						found_zone = true
						break
				
				if found_zone == true:
					break
			
			# Update Game Step
			if placed_hunters < MAX_HUNTERS:
				_on_game_step_update(Global.EGameSteps.PLACE_HUNTERS)
			else:
				queue_free()
