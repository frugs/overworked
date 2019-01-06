extends Sprite

func _process(delta):
    var intersect_offset = Vector2(96, 32)
    var intersect_pos = global_position + intersect_offset
    var results = get_world_2d().direct_space_state.intersect_point(intersect_pos)
    
    for result in results:
        var item = result.collider
        item.get_parent().remove_child(item)
        item.queue_free()
