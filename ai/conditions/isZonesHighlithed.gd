extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard) -> int:
	var is_zones_highlighted: bool = blackboard.get('zones_highlighted')
	
	return SUCCESS if is_zones_highlighted == true else FAILURE
