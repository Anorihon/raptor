extends Node
class_name Player

export(Global.EPlaySide) var play_side = Global.EPlaySide.RAPTORS setget play_side_set

var nickname = 'Player'

const RAPTOR_SCRIPT = preload('res://components/player/behaviours/raptor_behaviour.gd')
const HUNTER_SCRIPT = preload('res://components/player/behaviours/hunter_behaviour.gd')

onready var deck_node = $DeckManager
onready var behaviour_node = $Behaviour


# Called when the node enters the scene tree for the first time.
#func _ready():
#	behaviour_node.set_script(RAPTOR_SCRIPT if play_side == Global.EPlaySide.RAPTORS else HUNTER_SCRIPT)
#
#	init_deck()


func init_deck():
	deck_node.play_side = play_side
	deck_node.init()


func play_side_set(val):
	play_side = val
#	init_deck()
