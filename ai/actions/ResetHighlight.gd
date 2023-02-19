extends ActionLeaf

func tick(actor: Node, blackboard: Blackboard) -> int:
	var map_node: Map = blackboard.get('map_node')
	
	map_node.reset_highlight()
	blackboard.set("zones_highlighted", false)
	
	return SUCCESS
