extends ConditionLeaf

export (Global.EGameState) var check_state

func tick(actor, blackboard):
	var state: int = blackboard.get('state')
	
	return SUCCESS if state == check_state else FAILURE
