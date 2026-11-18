@icon("uid://8vbfp35d1md4")
class_name StateBase extends Node2D

#region _________________________________ exports ______________________________________________
@export_category("general_mobility")
@export var SPEED = 300.0
@export_group("jump")
@export var JUMP_VELOCITY = -400.0
@export var Jump_cutoff_vel := -100

@export_category("state specific")
@export_group("ground")
@export var ground_speed := 300
@export var ground_accel := 100
@export_subgroup("cayote_time")
@export var cayote_time_duration := 1.5


@export_group("air")
@export var air_speed := 300
@export var air_accel := 1.5
@export_subgroup("dive")
@export var dive_boost := -300
@export var dive_velocity := 500
@export var dive_accel := 2.5




@export_subgroup("jump buffer")
@export var jump_buffer_duration := 1.5

@export_category("suitcase")
@export var Bounce_force := -500
const  suitcase : PackedScene = preload("uid://83lbwqnoyfwg")


#endregion

#region ______________________________ onready ________________________________________________

@onready var controlled_node: = $"../.."
@onready var sprite = $"../../Node2D/AnimatedSprite2D"
@onready var player: CharacterBody2D = $"../.."


#endregion

var state_machine:StateMachine



#region ________________________________ process __________________________________________

var has_second_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := 0

var input_dir

var cayote_timer := 0.0
var jump_buffer_timer := 0.0

#endregion

func start():
	print("stateIdle")
	state_machine._change_to("StateIdle")
	
	
func on_process(delta):
	_get_directional_input(true)
	if input_dir != 0:
		state_machine._change_to("State_walking_ground")
	

func _get_directional_input(flip_with_input_direction: bool):
	input_dir = Input.get_axis(controlled_node.inputs.move_left,controlled_node.inputs.move_right) 
	if input_dir != 0:
		direction = sign(input_dir)
		if flip_with_input_direction == true:
			controlled_node.dir = direction
	

func _handle_jump():
	jump_buffer_timer = 0.0
	state_machine._change_to("StateJump")

func _call_suitcase():
	if not Input.is_action_just_pressed(controlled_node.inputs.throw) or controlled_node.suitcase_out == true:
		return
	var boomerang = suitcase.instantiate()
	
	boomerang.caller_group = "player1"
	boomerang.damage = controlled_node.current_damage
	print("direction ", direction)
	boomerang.init_dir = -direction
	if controlled_node.dir == 1:
		boomerang.base_rot = 0
	elif controlled_node.dir == -1:
		boomerang.base_rot = -PI
	boomerang.global_position = global_position
	get_tree().current_scene.add_child(boomerang)
	controlled_node.suitcase_out = true
		
func _call_attack():
	if controlled_node.suitcase_out == true:
		return
	if Input.is_action_just_pressed(controlled_node.inputs.attack):
		if controlled_node.is_on_floor():
			state_machine._change_to("StateAttack_Ground")
		else:
			state_machine._change_to("StateAttack_Air")
