@icon("uid://cetw14pdrhxun")
class_name StateAir extends StateBase


# Called when the node enters the scene tree for the first time.
func start():
	pass
	#state_machine._change_to("StateAir")
	
func on_process(delta):
	
	_call_suitcase()
	_get_directional_input(false)
	_apply_gravity(delta)
	_get_jump_buffer(delta)
	if controlled_node.is_on_floor():
		state_machine._change_to("StateIdle")
	
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, air_speed * input_dir, (air_accel * 1000) * delta )

func _apply_gravity(delta):
	controlled_node.velocity.y += gravity * delta

func _get_jump_buffer(delta):
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_duration
	if jump_buffer_timer >= 0.0:
		jump_buffer_timer -= delta
