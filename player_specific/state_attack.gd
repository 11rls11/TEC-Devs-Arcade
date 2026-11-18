class_name StateAttack_Ground extends StateIdle


# Called when the node enters the scene tree for the first time.
func start():
	pass
	
func on_process(delta):
	if not state_machine.animation_player.is_playing():
		print("animation finished")
		state_machine._change_to("StateIdle")
	if controlled_node.is_on_floor():
		controlled_node.velocity.x  = move_toward(controlled_node.velocity.x, 0.0 , (ground_speed * 10) * delta )
	else:
		state_machine._change_to("StateAir")
	
