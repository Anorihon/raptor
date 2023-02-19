extends Node

signal game_step_update
signal add_chip
signal locale_changed(lang_code)

signal hand_filled(play_side, cards)
signal card_clicked(card_data)


enum EGameState {
	MapGeneration,
	PlaceTRex,
	PlaceRaptors,
	PlaceHunters,
	PrepareDeck,
	SelectCards,
	CompareCards,
	PlayCardEvent,
	PlayActionPoints,
}

enum EPlaySide {
	RAPTORS,
	HUNTERS,
}

enum EMapObj {
	EMPTY = -1,
	MOUNTAINS = 2,
	CHALK = 3,
}

enum EMapTile {
	EMPTY = -1,
	EXIT = 0,
	SAVANNAH = 1,
	GRASS = 2,
}

enum EGameSteps {
	PLACE_TREX,
	PLACE_DINO,
	PLACE_HUNTERS,
	SELECT_CARD,
}

enum EChip {
	TREX,
	RAPTOR,
	HUNTER,
}

enum EPlaceZone {
	TREX,
	RAPTOR,
	HUNTER,
}

var game_step = EGameSteps.PLACE_TREX setget game_step_set


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()


func rotate_array(arr) -> Array:
	var new_arr = []
	
	for i in range(len(arr[0])):
		var row = []
		for j in range(len(arr)):
			row.append(arr[len(arr) - j - 1][i])
		new_arr.append(row)
	return new_arr


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	
	dir.list_dir_end()
	
	return files


func game_step_set(val):
	if game_step == val:
		return
	
	game_step = val
	emit_signal("game_step_update", game_step)
