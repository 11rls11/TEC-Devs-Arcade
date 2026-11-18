extends Node

var player_on_scene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _player_hurt(player,damage):
	var player_machine = player.get_node("StateMachine")
	if not player_machine.current_state.name == "StateHit" :
		player.hp -= damage
		player_machine._change_to("StateHit")
		
