extends Object

var items = []
var owner = null

func _init(node):
    owner = node

func is_empty():
    return items.empty()

func has_item(item):
    return items.find(item) > -1

func add_item(item):
    items.push_back(item)
    if owner.has_method("acquire_item"):
        owner.acquire_item(item)

func remove_item(item):
    var idx = items.find(item)
    if idx > -1:
        items.remove(idx)
        if owner.has_method("release_item"):
            owner.release_item(item)

func give_item(item, inventory):
    remove_item(item)
    inventory.add_item(item)
        
func front():
    return items[0]