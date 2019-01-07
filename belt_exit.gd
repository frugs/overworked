extends Sprite

onready var _belt_body = get_node("../belt_body")

func _process(delta):
    var intersect_offset = Vector2(96, 32)
    var intersect_pos = global_position + intersect_offset
    var results = get_world_2d().direct_space_state.intersect_point(intersect_pos)
    
    for result in results:
        if "score_value" in result:
            var item = result.collider
            _belt_body.remove(item)            
            item.queue_free()
