class_name StateAttack_Air extends StateAir


# Called when the node enters the scene tree for the first time.
func start():
	pass
	
func on_process(delta):
	_get_directional_input(false)
	_apply_gravity(delta)
	if not state_machine.animation_player.is_playing():
		print("animation finished")
		state_machine._change_to("StateAir")
	if not controlled_node.is_on_floor():
		controlled_node.velocity.x  = move_toward(controlled_node.velocity.x, air_speed * input_dir, (air_accel/2 * 1000) * delta )
	else:
		state_machine._change_to("StateIdle")
