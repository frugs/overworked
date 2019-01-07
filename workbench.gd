extends StaticBody2D

const Inventory = preload("res://inventory.gd")

var inventory = Inventory.new(self)

func interact_with(player, items):
    if not player.inventory.is_empty() and inventory.is_empty():
        player.inventory.give_item(player.inventory.front(), inventory)
                
    elif player.inventory.is_empty() and not inventory.is_empty():
        inventory.give_item(inventory.front(), player.inventory)
        
func acquire_item(item):
    item.position = Vector2()
    add_child(item)
        
func release_item(item):
    remove_child(item)
