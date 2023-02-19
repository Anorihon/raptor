extends Node
class_name DeckManager

export (Global.EPlaySide) var play_side = Global.EPlaySide.RAPTORS
var deck = []
var discard = []
var hand = []


func _ready():
	randomize()


func init():
	var folder_name = 'raptors' if play_side == Global.EPlaySide.RAPTORS else 'hunters'
	
	# Reset lists
	deck = []
	discard = []
	hand = []
	
	# Fill deck
	for i in 9:
		var num = i + 1
		var res = load('res://components/card/' + folder_name + '/card_' + str(num) + '.tres').duplicate()
		
		deck.append(res)
	
	deck.shuffle()
	
	# Fill hand
	for i in 3:
		take_card()
	
	Global.emit_signal("hand_filled", play_side, hand)


func take_card() -> void:
	if deck.size() == 0:
		deck = discard.duplicate(true)
		deck.shuffle()
		discard = []
	
	hand.append(deck.pop_back())
