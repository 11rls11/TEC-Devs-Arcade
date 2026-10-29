@icon("uid://c2kmgkg53hlpn")
class_name StateAir_e extends StateBase_e


# Called when the node enters the scene tree for the first time.
func start():

	pass
	
	#state_machine._change_to("State_walking_ground")
	
func on_process(delta):
	if not controlled_node.is_on_floor():
		_apply_gravity(delta)
	else:
		state_machine._change_to("StateIdle_e")
		return
	#controlled_node.move_and_slide()

func _apply_gravity(delta):
	controlled_node.velocity.y += gravity * delta
