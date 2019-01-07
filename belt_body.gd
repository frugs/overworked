extends StaticBody2D

func interact_with(player):
    var results = get_world_2d().direct_space_state.intersect_point(player.interaction_point())
    for result in results:
        if result.collider.has_method("give_to"):
            result.collider.give_to(player)
            break