extends KinematicBody2D

const MOTION_SPEED = 256.0
const CELL_SIZE = 64

var carried_item = null

var _move_direction = Vector2()
var _facing = Vector2(0, 1)
var _idle_anim_name = "idle_down"
var _action_stack = [] 

onready var _animation_player = get_node("animation_player")

func _face_direction_of_input():
    for action in ["ui_up", "ui_down", "ui_left", "ui_right"]:
        if Input.is_action_just_pressed(action):
            var index = _action_stack.find(action)
            if index >= 0:
                _action_stack.remove(index)
            _action_stack.push_front(action)
            if _action_stack.size() > 4:
                _action_stack.resize(4)
    
    var no_input = true
    for action in _action_stack:
                           
        if action == "ui_up" and Input.is_action_pressed(action):
            no_input = false
            _facing = Vector2(0, -1)
            _idle_anim_name = "idle_up"
            if _move_direction != _facing:
                _move_direction = _facing
                _animation_player.play("move_up")
            break
            
        if action == "ui_down" and Input.is_action_pressed(action):
            no_input = false
            _facing = Vector2(0, 1)
            _idle_anim_name = "idle_down"
            if _move_direction != _facing:
                _move_direction = _facing
                _animation_player.play("move_down")
            break
            
        if action == "ui_left" and Input.is_action_pressed(action):
            no_input = false
            _facing = Vector2(-1, 0)        
            _idle_anim_name = "idle_left"
            if _move_direction != _facing:
                _move_direction = _facing
                _animation_player.play("move_left")
            break
    
        if action == "ui_right" and Input.is_action_pressed(action):
            no_input = false
            _facing = Vector2(1, 0)
            _idle_anim_name = "idle_right"
            if _move_direction != _facing:
                _move_direction = _facing
                _animation_player.play("move_right")
            break
            
    if no_input:
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
    