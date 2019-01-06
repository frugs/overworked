extends KinematicBody2D

const MOTION_SPEED = 256.0
const CELL_SIZE = 64

var carried_item = null

var _motion = Vector2()
var _move_direction = Vector2()
var _facing = Vector2(0, 1)
var _idle_anim_name = "idle_down"

onready var _animation_player = get_node("animation_player")

func _face_direction_of_input():
    if Input.is_action_pressed("ui_up"):
        _facing = Vector2(0, -1)
        _idle_anim_name = "idle_up"
        if _move_direction != _facing:
            _move_direction = _facing
            _animation_player.play("move_up")
    elif Input.is_action_pressed("ui_down"):
        _facing = Vector2(0, 1)
        _idle_anim_name = "idle_down"
        if _move_direction != _facing:
            _move_direction = _facing
            _animation_player.play("move_down")
    elif Input.is_action_pressed("ui_left"):
        _facing = Vector2(-1, 0)        
        _idle_anim_name = "idle_left"
        if _move_direction != _facing:
            _move_direction = _facing
            _animation_player.play("move_left")
    elif Input.is_action_pressed("ui_right"):
        _facing = Vector2(1, 0)
        _idle_anim_name = "idle_right"
        if _move_direction != _facing:
            _move_direction = _facing
            _animation_player.play("move_right")
    else:
        _move_direction = Vector2()
        _animation_player.play(_idle_anim_name)
    
func _process(delta):
    _face_direction_of_input()
    
    if Input.is_action_just_pressed("ui_accept"):
        var intersect_offset = Vector2(32, 32) + _facing * CELL_SIZE
        var intersect_pos = global_position + intersect_offset
        var results = get_world_2d().direct_space_state.intersect_point(intersect_pos)
        for result in results:
           if result.collider.has_method("interact_with"):
                result.collider.interact_with(self)

func _physics_process(delta):
    move_and_slide(_move_direction * MOTION_SPEED)
    