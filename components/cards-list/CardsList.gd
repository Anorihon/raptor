extends HBoxContainer
class_name CardsList

onready var card_nodes = get_children()
onready var total_cards = card_nodes.size()

func _ready():
	hide_all()


func hide_all():
	for card_node in card_nodes:
		card_node.visible = false


func show_cards(cards_data: Array):
	for i in total_cards:
		var card_node = card_nodes[i]
		var card_data = cards_data[i] if i < total_cards else null
		
		if card_data:
			card_node.card_data = card_data
		card_node.visible = true if card_data else false
