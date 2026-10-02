@icon("uid://mw7p4w4hobsj")
class_name StateIdle extends StateBase








func start():
	pass
	
	#state_machine._change_to("StateIdle")
	
func on_process(delta):
	if not controlled_node.is_on_floor():
		_handle_unflooring()
	else:
		controlled_node.velocity.y = 0
	input_dir = Input.get_axis("move_left","move_right") 
	if input_dir != 0:
		direction = input_dir
		state_machine._change_to("State_walking_ground")
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, 0.0 , (ground_speed * 1000) * delta )
		
	if Input.is_action_just_pressed("jump"):
		_handle_jump()

func _handle_unflooring():
	controlled_node.velocity.y = 0.0
	state_machine._change_to("StateAir")
