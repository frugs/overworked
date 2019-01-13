extends KinematicBody2D

const MOTION_SPEED = 256.0
const CELL_SIZE = 64

const Inventory = preload("res://inventory.gd")

var inventory = Inventory.new(self)

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
        
func _find_entities_in_front_of_player():
    var intersect_offset = Vector2(32, 48) + _facing * CELL_SIZE * 0.75
    var interaction_point = global_position + intersect_offset
    var results = get_world_2d().direct_space_state.intersect_point(interaction_point)
    
    var machines = []
    var items = []
    for result in results:
        if result.collider.has_method("interact_with"):
            machines.push_back(result.collider)
        elif "score_value" in result.collider:
            items.push_back(result.collider)
    
    return {"machines": machines, "items": items}

func _do_interact():
    var entities = _find_entities_in_front_of_player()

    if not entities.empty():             
        entities.machines[0].interact_with(self, entities.items)
        
func _do_operate():
    var entities = _find_entities_in_front_of_player()
    if not entities.empty() and entities.machines[0].has_method("operate"):
       entities.machines[0].operate(self)
    
func _process(delta):
    _face_direction_of_input()
    
    if Input.is_action_just_pressed("game_interact"):
        _do_interact()
    elif Input.is_action_pressed("game_operate"):
        _do_operate()

func _physics_process(delta):
    move_and_slide(_move_direction * MOTION_SPEED)
    
func release_item(item):
    remove_child(item)
    
func acquire_item(item):
    item.position = Vector2()
    add_child(item)
