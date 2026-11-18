extends Node

const P1_inputs := preload("uid://cgojg8xselgc1")
const P2_inputs := preload("uid://cy0vlvcfjyb6h")

const Player_blueprint := preload("uid://dfkfh4c0lkxqq")

var player1 
var player2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_inputs()
	get_tree().scene_changed.connect(_set_inputs)
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if  _ask_for_P2(event) or Input.is_action_just_pressed("Spawn_player") :
		if player1 != null and player2 == null:
			
				var new_player = Player_blueprint.instantiate()
				new_player.global_position = player1.global_position + Vector2(10,-10)
				get_tree().current_scene.add_child(new_player)
				_set_inputs()
				print("Player 2 joined!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:


			
	pass

func _set_inputs():
	if get_tree().has_group("player"):
		print("there are players!")
		var players := get_tree().get_nodes_in_group("player")
		player1 = players[0]
		if player1 != null :
			player1.add_to_group("player1")
			player1.inputs = P1_inputs
		if players.size() >= 2:
			player2 = players[1]
			if player1 != null :
				player2.add_to_group("player2")
				player2.inputs = P2_inputs

func _ask_for_P2(event: InputEvent) -> bool:
	if not event.is_pressed() or event.is_echo():
		return false

	for action in InputMap.get_actions():
		if String(action).begins_with("p2_") and event.is_action_pressed(action):
			return true

	return false
