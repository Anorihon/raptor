extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard) -> int:
	var excluded_zones_reseted = blackboard.get('excluded_zones_reseted')
	
	if excluded_zones_reseted == true:
		return SUCCESS
	
	return FAILURE
