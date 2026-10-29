class_name StateBase_e extends Node2D
#region ____________________________________ export _______________________________
@export_group("velocity specific")
@export var ground_drag := 1.0

@export_group("on death specific")
@export_range(1.0,2.0)
var fucked_scale_multiplier := 1.0

#endregion

#region ___________________________________ onready __________________________________



var controlled_node: CharacterBody2D 


var state_machine : StateMachine_e
# Called when the node enters the scene tree for the first time.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func start():
	pass
	
	
	#state_machine._change_to("State_walking_ground")
	
func on_process(delta):
	state_machine._change_to("StateIdle_e")
	pass
