extends StateAir


# Called when the node enters the scene tree for the first time.
func start():
	controlled_node.velocity.y += JUMP_VELOCITY
	
func on_process(delta):
	
	_get_directional_input(true)
	_call_suitcase()
	_call_attack()
	_apply_gravity(delta)
	_get_jump_buffer(delta)
	_get_dive()

	
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, air_speed * input_dir, (air_accel * 1000) * delta )
	if Input.is_action_just_released("jump") or controlled_node.velocity.y > -100:
		controlled_node.velocity.y = JUMP_VELOCITY  / 6
		state_machine._change_to("StateAir")
