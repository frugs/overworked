extends StaticBody2D

onready var _global = get_node("/root/global")

func interact_with(player):
    if not player.carried_item == null:
        var item = player.carried_item
        player.carried_item = null
    
        _global.score += item.score_value    
        item.get_parent().remove_child(player.carried_item)
        item.queue_free()