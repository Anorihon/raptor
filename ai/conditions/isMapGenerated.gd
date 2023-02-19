extends ConditionLeaf

func tick(actor, blackboard):
	var is_map_generated: bool = blackboard.get('map_generated')
	
	return SUCCESS if is_map_generated == true else FAILURE
