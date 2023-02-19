extends ConditionLeaf


func tick(actor: Game, blackboard: Blackboard):
	var raptor_card: CardData = blackboard.get('raptor_card')
	var hunter_card: CardData = blackboard.get('hunter_card')
	
	return SUCCESS if raptor_card.power == hunter_card.power else FAILURE
