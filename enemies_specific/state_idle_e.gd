@icon("uid://sps1xh8x4ylo")
class_name StateIdle_e extends StateBase_e

# Called when the node enters the scene tree for the first time.
func start():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	if not controlled_node.is_on_floor():
		state_machine._change_to("StateAir_e")
		return 
	
	# Only runs if the enemy IS safely on the floor
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, 0, (ground_drag * 1000) * delta)
	controlled_node.velocity.y = 0
