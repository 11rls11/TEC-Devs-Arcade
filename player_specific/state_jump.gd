extends StateAir


# Called when the node enters the scene tree for the first time.
func start():
	controlled_node.velocity.y += JUMP_VELOCITY
	
func on_process(delta):
	
	state_machine._change_to("StateAir")
