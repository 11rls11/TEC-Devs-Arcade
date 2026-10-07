@icon("uid://mw7p4w4hobsj")
class_name StateIdle extends StateBase








func start():
	cayote_timer = cayote_time_duration
	pass
	
	#state_machine._change_to("StateIdle")
	
func on_process(delta):
	_get_directional_input(true)
	_call_suitcase()
	if not controlled_node.is_on_floor():
		_handle_unflooring(delta)
	
	
	if input_dir != 0:
		state_machine._change_to("State_walking_ground")
	else:
		controlled_node.velocity.x = move_toward(controlled_node.velocity.x, 0.0 , (ground_speed * 1000) * delta )
		
	if Input.is_action_just_pressed("jump") or jump_buffer_timer > 0.0:
		_handle_jump()

func _handle_unflooring(delta):
	if cayote_timer >= 0 :
		controlled_node.velocity.y = 0.0
		cayote_timer -= delta
		print("cayote time")
		return
	
	state_machine._change_to("StateAir")
