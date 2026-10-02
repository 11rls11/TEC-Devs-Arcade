extends StateAir


# Called when the node enters the scene tree for the first time.
func start():
	
	state_machine._change_to("StateJump")
	
func on_process(delta):
	
		
	if Input.get_axis("move_left","move_right") != 0:
		direction = Input.get_axis("move_left","move_right")
