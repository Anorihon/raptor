extends ConditionLeaf

var is_click_done = false
var cell_info = {}


func tick(actor:Game, blackboard:Blackboard) -> int:
	var map_node: Map = actor.map_node
	
	if not map_node.is_connected("click_zone_cell", self, "_on_click_zone_cell"):
		map_node.connect("click_zone_cell", self, "_on_click_zone_cell", [], CONNECT_ONESHOT)
	
	if is_click_done:
		blackboard.set('clicked_cell', cell_info)
		is_click_done = false
		
		return SUCCESS
	
	return RUNNING


func _on_click_zone_cell(cell_position, tile_index, obj_index):
	self.cell_info.position = cell_position
	self.cell_info.tile_index = tile_index
	self.cell_info.obj_index = obj_index
	
	self.is_click_done = true
