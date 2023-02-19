extends ConditionLeaf

export (Global.EChip) var chip_type = Global.EChip.TREX
export (int) var limit = 1

func tick(actor: Node, blackboard: Blackboard) -> int:
	var chips = get_tree().get_nodes_in_group(Global.EChip.keys()[chip_type].to_lower())
	
#	print('Placed chips ', Global.EChip.keys()[chip_type].to_lower(), ' Size: ', chips.size(), ' Limit: ', limit)
	
	if chips.size() == limit:
		return SUCCESS
	
	return FAILURE
