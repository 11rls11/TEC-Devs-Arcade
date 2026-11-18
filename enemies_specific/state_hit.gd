extends StateBase_e


# Called when the node enters the scene tree for the first time.
func start():
	if controlled_node.HP <= 0:
		state_machine._change_to("StateGetFucked")
	else:
		state_machine._change_to("StateIdle_e")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
