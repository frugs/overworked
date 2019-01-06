extends Label

onready var _global = get_node("/root/global")

func _process(delta):
    text = String(_global.score)
