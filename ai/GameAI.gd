extends BeehaveRoot

func _ready():
	yield(get_tree().root, "ready")
