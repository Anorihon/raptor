extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard) -> int:	
	blackboard.set('excluded_zones', [])
	
	return SUCCESS
