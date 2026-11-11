extends StateAir

@export var input_correction_strength := 2.0

var dive_input_correction : = 1.0

# Called when the node enters the scene tree for the first time.
# Called when the node enters the scene tree for the first time.
func start():
	print("used dir ", direction)
	if controlled_node.velocity.y < dive_boost:
		controlled_node.velocity.y += dive_boost
	else:
		controlled_node.velocity.y = dive_boost
	
func on_process(delta):
	_get_directional_input(false)
	_apply_gravity(delta)
	print(direction)
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x, (dive_velocity * controlled_node.dir) / (dive_input_correction) , (dive_accel* 1000) * delta)
	if sign(controlled_node.velocity.x) + direction == 0:
		dive_input_correction = input_correction_strength
		print("correcting")
	else:
		dive_input_correction = 1
	if controlled_node.is_on_floor():
		state_machine._change_to("StateAir")
