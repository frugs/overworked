extends KinematicBody2D

var score_value = 20

func give_to(player):
    if player.carried_item == null:
        get_parent().remove_child(self)
        player.add_child(self)
        player.carried_item = self
        position = Vector2()