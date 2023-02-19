extends ConditionLeaf

export (Global.EPlaySide) var play_side


func tick(actor: Game, blackboard: Blackboard):
	var card_data = blackboard.get('raptor_card' if play_side == Global.EPlaySide.RAPTORS else 'hunter_card')
	
	if card_data == null:
		return FAILURE
	
	return SUCCESS
