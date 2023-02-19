extends ActionLeaf

enum EList {
	RaptorHand,
	HunterHand,
	SelectedCards,
}

export (EList) var list_type


func tick(actor: Game, blackboard):
	var raptor_deck: DeckManager = actor.raptor_deck
	var hunter_deck: DeckManager  = actor.hunter_deck
	var cards_list: CardsList = actor.cards_list
	var show_cards = []
	
	match list_type:
		EList.RaptorHand:
			show_cards = raptor_deck.hand
		EList.HunterHand:
			show_cards = hunter_deck.hand
	
	cards_list.show_cards(show_cards)
	
	return SUCCESS
