extends ActionLeaf


func tick(actor: Game, blackboard:Blackboard) -> int:
	var map_node: Map = actor.map_node
	
	if !map_node:
		print('No map node')
		return FAILURE
	
	map_node.fill_zones()
	map_node.generate_map()
	map_node._on_viewport_size_changed()
	print('Map node generated')
	
	return SUCCESS
