extends ActionLeaf


func tick(actor: Game, blackboard):
	var raptor_deck: DeckManager = actor.raptor_deck
	var hunter_deck: DeckManager  = actor.hunter_deck
	
	raptor_deck.init()
	hunter_deck.init()
	
	return SUCCESS
