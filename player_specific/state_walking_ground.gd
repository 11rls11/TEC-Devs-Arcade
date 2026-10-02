extends StateIdle


# Called when the node enters the scene tree for the first time.
func start():
	pass
	
	#state_machine._change_to("State_walking_ground")
	
func on_process(delta):
	_get_directional_input(true)
	if not controlled_node.is_on_floor():
		_handle_unflooring()
	if Input.is_action_just_pressed("jump"):
		_handle_jump()
	
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, ground_speed * input_dir, (ground_accel * 1000) * delta )
	#print((ground_accel * 100) * delta )
