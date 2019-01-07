extends StaticBody2D

onready var _global = get_node("/root/global")

func interact_with(player, items):
    if not player.inventory.is_empty():
        var item = player.inventory.items[0]
        player.inventory.remove_item(item)
    
        _global.score += item.score_value    

        item.queue_free()
