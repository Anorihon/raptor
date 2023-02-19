extends ConditionLeaf

export (Global.EPlaySide) var play_side
var is_click_done = false
var card_data: CardData = null


func tick(actor: Game, blackboard):
	var map_node: Map = actor.map_node
	
	if is_click_done:
		blackboard.set('raptor_card' if play_side == Global.EPlaySide.RAPTORS else 'hunter_card', card_data)
		is_click_done = false
		
		return SUCCESS
	
	if not Global.is_connected("card_clicked", self, "_on_card_click"):
		Global.connect("card_clicked", self, "_on_card_click", [], CONNECT_ONESHOT)
	
	return RUNNING


func _on_card_click(card_data: CardData):
	print(card_data)
	self.card_data = card_data
	self.is_click_done = true
