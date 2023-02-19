extends ActionLeaf

func tick(actor: Game, blackboard: Blackboard):
	var cards_list: CardsList = actor.cards_list
	
	cards_list.hide_all()
	
	return SUCCESS
