@icon("uid://8vbfp35d1md4")
class_name StateBase extends Node2D

#region _________________________________ exports ______________________________________________
@export_category("general_mobility")
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

@export_category("state specific")
@export_group("ground")
@export var ground_speed := 300
@export var ground_accel := 1.5

@export_group("air")
@export var air_speed := 300
@export var air_accel := 1.5

@export_category("suitcase")
@export var suitcase : PackedScene = preload("uid://83lbwqnoyfwg")

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
var direction = 1
var input_dir


#endregion

func start():
	print("stateIdle")
	state_machine._change_to("StateIdle")
	
	
func on_process(delta):
	_get_directional_input(true)
	if input_dir != 0:
		state_machine._change_to("State_walking_ground")
	

func _get_directional_input(flip_with_input_direction: bool):
	input_dir = Input.get_axis("move_left","move_right") 
	if input_dir != 0 and flip_with_input_direction == true:
		direction = sign(input_dir)
	

func _handle_jump():
	state_machine._change_to("StateJump")

func _call_suitcase():
	if not Input.is_action_just_pressed("throw"):
		return
	var boomerang = suitcase.instantiate()
	
	boomerang.caller_group = "player1"
	if direction > 0:
		boomerang.base_rot = 0
	else:
		boomerang.base_rot = -PI
	boomerang.global_position = global_position
	get_tree().current_scene.add_child(boomerang)
		
