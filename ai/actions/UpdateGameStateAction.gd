extends ActionLeaf

export (Global.EGameState) var next_state

func tick(actor, blackboard):
	blackboard.set('state', next_state)
	
	return SUCCESS
