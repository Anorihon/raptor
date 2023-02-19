extends TextureButton

const BORDER_ANIM_DURATION = .5

var card_data: CardData setget card_data_set
onready var border_node = $Border
onready var tween = $Tween
onready var desc_box_node = $DescBox

func _ready():
	connect("button_up", self, "_on_button_up")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("tree_exiting", self, "_on_tree_exiting")
	Global.connect("locale_changed", self, "_on_locale_changed")


func _on_locale_changed(locale):
	desc_box_node.get_node("ColorRect/ScrollContainer/Label").text = tr('RAPTOR_CARD_' + str(card_data.power))

func _on_button_up():
	print("wololo")
	Global.emit_signal("card_clicked", card_data)


func _on_mouse_entered():
	desc_box_node.visible = true
	
	tween.stop_all()
	tween.interpolate_property(border_node, 'self_modulate', border_node.self_modulate, Color(1, 1, 1, 1), BORDER_ANIM_DURATION)
	tween.start()

func _on_mouse_exited():
	desc_box_node.visible = false
	
	tween.stop_all()
	tween.interpolate_property(border_node, 'self_modulate', border_node.self_modulate, Color(1, 1, 1, 0), BORDER_ANIM_DURATION)
	tween.start()

func _on_tree_exiting():
	disconnect("button_up", self, "_on_button_up")
	disconnect("mouse_entered", self, "_on_mouse_entered")
	disconnect("mouse_exited", self, "_on_mouse_exited")
	disconnect("tree_exiting", self, "_on_tree_exiting")
	
	Global.disconnect("locale_changed", self, "_on_locale_changed")
	
#	desc_hover_box_node.disconnect("mouse_entered", self, "_on_desc_hover_box_hover")
#	desc_hover_box_node.disconnect("mouse_exited", self, "_on_desc_hover_box_mouse_exited")

func card_data_set(val: CardData):
	card_data = val
	texture_normal = card_data.card
	
	desc_box_node.get_node("ColorRect/ScrollContainer/Label").text = tr('RAPTOR_CARD_' + str(val.power))
#	print(tr("RAPTOR_CARD_" + str(card_data.power)))
