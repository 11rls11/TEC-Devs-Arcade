@icon("uid://8vbfp35d1md4")
class_name StateBase extends Node2D

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

@onready var controlled_node: = $"../.."

var state_machine:StateMachine
@export var velocity = 5

var has_second_jumped = false

var direction = 1
var input_dir

@onready var sprite = $"../../Node2D/AnimatedSprite2D"

func start():
	
	state_machine._change_to("StateIdle")
	
func on_process(delta):
	input_dir
	if Input.get_axis("move_left","move_right") != 0:
		direction = Input.get_axis("move_left","move_right") 
