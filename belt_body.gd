extends StaticBody2D

func interact_with(player, items):
    for item in items:
        item.give_to(player)
