@icon("uid://mw7p4w4hobsj")
class_name StateIdle extends StateBase








func start():
	pass
	
	#state_machine._change_to("StateIdle")
	
func on_process(delta):
	if not controlled_node.is_on_floor():
		_handle_unflooring(0.0)
	else:
		controlled_node.velocity.y = 0
	input_dir = Input.get_axis("move_left","move_right") 
	if input_dir != 0:
		direction = input_dir
		state_machine._change_to("State_walking_ground")
	

func _handle_unflooring(exit_velocity_y:float):
	controlled_node.velocity.y += exit_velocity_y
	state_machine._change_to("StateAir")
