extends StateAir_e


# Called when the node enters the scene tree for the first time.
func start():
	controlled_node.collision_layer = 2
	controlled_node.collision_mask = 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	#print(controlled_node.velocity)
	controlled_node.rotate(1.5)
	controlled_node.scale *= 1.05
	if not controlled_node.is_on_floor():
		_apply_gravity(delta)
	elif controlled_node.velocity.y > -100:
		controlled_node.queue_free()
