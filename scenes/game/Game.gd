extends Node2D
class_name Game

#onready var deck_manager = $RaptorDeckManager
#onready var player_hand_node = $CanvasLayer/VBoxContainer/Control/PlayerHand

onready var ai_node = $GameAI
onready var map_node = $Map
onready var raptor_deck: DeckManager = $"%RaptorDeckManager"
onready var hunter_deck: DeckManager = $"%HunterDeckManager"
onready var cards_list: CardsList = $"%CardsList"

func _ready():
	TranslationServer.set_locale('en')
	
	var blackboard = Blackboard.new()
	
	blackboard.set("map_node", map_node)
	blackboard.set("excluded_zones", [])
	blackboard.set("zones_highlighted", false)
	blackboard.set("state", false)
	
	ai_node.blackboard = blackboard
	
#	var cards = deck_manager.hand
#
#	for i in player_hand_node.get_child_count():
#		var card_node = player_hand_node.get_child(i)
#		var card_data = cards[i] if i < cards.size() else null
#
#		if card_data == null:
#			card_node.visible = false
#		else:
#			card_node.card_data = card_data
#			card_node.visible = true
	
	
	
#	var raptor_card_files = Global.list_files_in_directory('res://components/card/raptors/')
#
#	for file in raptor_card_files:
#		print(file)
#		var card_data = load(file_path).new()
#		print(card_data.new().power)
##	OS.window_fullscreen = true
#
#	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")
#	_on_viewport_size_changed()
#
#
#func _on_viewport_size_changed():
#	$CanvasLayer/VBoxContainer/Control/HBoxContainer.update()
