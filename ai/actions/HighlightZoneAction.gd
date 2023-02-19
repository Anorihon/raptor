extends ActionLeaf

export (Global.EPlaceZone) var place_zone = Global.EPlaceZone.TREX

func tick(actor:Node, blackboard:Blackboard) -> int:
	var map_node: Map = blackboard.get('map_node')
	var excluded_zones: Array = blackboard.get('excluded_zones')
	
	map_node.highlight_place_zones(place_zone, excluded_zones)
	blackboard.set("zones_highlighted", true)
	
	return SUCCESS
