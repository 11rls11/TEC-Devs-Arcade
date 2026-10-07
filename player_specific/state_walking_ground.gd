extends StateIdle


# Called when the node enters the scene tree for the first time.
func start():
	cayote_timer = cayote_time_duration
	pass
	
	#state_machine._change_to("State_walking_ground")
	
func on_process(delta):
	_call_suitcase()
	_get_directional_input(true)
	if not controlled_node.is_on_floor():
		_handle_unflooring(delta)
	if Input.is_action_just_pressed("jump"):
		_handle_jump()
	if input_dir != 0:
		controlled_node.velocity.x = move_toward(controlled_node.velocity.x, ground_speed * input_dir, (ground_accel * 1000) * delta )
	else:
		state_machine._change_to("StateIdle")
	#print((ground_accel * 100) * delta )
