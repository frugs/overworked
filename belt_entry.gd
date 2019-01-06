extends Sprite

const CELL_SIZE_F = 64.0
const BELT_SPEED = 32
const SPAWN_INTERVAL = 3 * CELL_SIZE_F / BELT_SPEED

const Material = preload("res://material_0.tscn")

var _spawn_timer = 0

func _process(delta):
    _spawn_timer -= delta
    
    if _spawn_timer <= 0.0:
        _spawn_timer = SPAWN_INTERVAL
        add_child(Material.instance())
    
    for child in get_children():
        child.position.x += BELT_SPEED * delta
