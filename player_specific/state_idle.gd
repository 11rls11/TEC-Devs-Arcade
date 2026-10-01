@icon("uid://mw7p4w4hobsj")
class_name StateIdle extends StateBase

#region ____________ vars globales ___________________________
var rapidez_suelo = controlled_node.ground_speed
#endregion

#region ___________ vars locales ___________________________
var velocidad : Vector2
#endregion






func start():
	
	state_machine._change_to("StateIdle")
	
func on_process(delta):
	
	if Input.get_axis("move_left","move_right") != 0:
		direction = Input.get_axis("move_left","move_right") 


func _actualizar_varibles():
	controlled_node.velocity.x = velocidad.x
