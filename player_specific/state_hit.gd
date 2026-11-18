class_name StateHit extends StateBase


# Called when the node enters the scene tree for the first time.
func start():
	controlled_node.velocity.x = ground_speed * controlled_node.dir * -1
	pass
	
func on_process(delta):
	if not state_machine.animation_player.is_playing():
		if controlled_node.is_on_floor():
			state_machine._change_to("StateIdle")
		else:
			state_machine._change_to("StateAir")
