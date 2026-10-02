@icon("uid://cetw14pdrhxun")
class_name StateAir extends StateBase


# Called when the node enters the scene tree for the first time.
func start():
	pass
	#state_machine._change_to("StateAir")
	
func on_process(delta):
	if controlled_node.is_on_floor():
		state_machine._change_to("StateIdle")
	controlled_node.velocity.y += gravity * delta
	if Input.get_axis("move_left","move_right") != 0:
		direction = Input.get_axis("move_left","move_right")
