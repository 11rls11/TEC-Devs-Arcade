extends StateAir_e


# Called when the node enters the scene tree for the first time.
func start():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	#print(controlled_node.velocity)
	if not controlled_node.is_on_floor():
		_apply_gravity(delta)
	else:
		controlled_node.queue_free()
