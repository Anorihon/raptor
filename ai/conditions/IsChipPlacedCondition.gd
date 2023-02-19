extends ConditionLeaf

export (Global.EChip) var chip_type = Global.EChip.TREX

func tick(actor: Node, blackboard: Blackboard) -> int:
	var chips = get_tree().get_nodes_in_group(Global.EChip.keys()[chip_type].to_lower())
	
	if chips.size() == 0:
		return FAILURE
	
	return SUCCESS
