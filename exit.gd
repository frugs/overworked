extends StaticBody2D

onready var _global = get_node("/root/global")

func interact_with(player, items):
    if not player.carried_item == null:
        var item = player.carried_item
        player.carried_item = null
    
        _global.score += item.score_value    
        item.get_parent().remove_child(item)
        item.queue_free()
