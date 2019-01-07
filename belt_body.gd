extends StaticBody2D

const Inventory = preload("res://inventory.gd")

var inventory = Inventory.new(self)

onready var _belt_entry = get_node("../belt_entry")

func interact_with(player, items):
    if not player.inventory.is_empty() and items.empty():
        # set new local position before reparenting
        var item = player.inventory.front()
        item.position = Vector2(player.global_position.x, 0)
        
        player.inventory.give_item(item, inventory)

    elif player.inventory.is_empty() and not items.empty():
        inventory.give_item(items[0], player.inventory)

func acquire_item(item):
    _belt_entry.add_child(item)
    
func release_item(item):
    _belt_entry.remove_child(item)