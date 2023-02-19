extends ActionLeaf

export (Global.EChip) var chip_type = Global.EChip.TREX


func tick(actor:Node, blackboard:Blackboard) -> int:
	var map_node: Map = blackboard.get('map_node')
	var clicked_cell = blackboard.get('clicked_cell')
	var excluded_zones = blackboard.get('excluded_zones')
	var cell_pos = map_node.get_cell_position(clicked_cell.position.x, clicked_cell.position.y)
	
	match chip_type:
		Global.EChip.TREX:
			excluded_zones.append(1 if clicked_cell.position.y <= 2 else 4)
		Global.EChip.RAPTOR:
			# Exclude zone
			for zone_index in map_node.zones.main.size():
				var found_zone = false
				var cells = map_node.zones.main[zone_index]
				
				for cell in cells:
					if cell.x == clicked_cell.position.x && cell.y == clicked_cell.position.y:
						excluded_zones.append(zone_index)
						found_zone = true
						break
				
				if found_zone == true:
					break
		Global.EChip.HUNTER:
			for zone_index in map_node.zones.hunters.size():
				var found_zone = false
				var cells = map_node.zones.hunters[zone_index]
				
				for cell in cells:
					if cell.x == clicked_cell.position.x && cell.y == clicked_cell.position.y:
						excluded_zones.append(zone_index)
						found_zone = true
						break
				
				if found_zone == true:
					break
	
	blackboard.set('excluded_zones', excluded_zones)
	
	Global.emit_signal("add_chip", chip_type, cell_pos)
	
	return SUCCESS
