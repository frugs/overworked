extends StaticBody2D

var contents = null

func interact_with(player, items):
    if player.carried_item != null:
        var item = player.carried_item
        player.carried_item = null
        
        item.get_parent().remove_child(item)        
        item.position = Vector2()
        add_child(item)
    else:
        for item in items:
            item.give_to(player)
            break
