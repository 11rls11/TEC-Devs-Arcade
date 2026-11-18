class_name StateMachine extends Node

@onready var controlled_node = $".."

@export var default_state: StateBase

var player_sprite : AnimatedSprite2D 
var player_collision : CollisionShape2D 

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var fallback_animation := "StateIdle"

#endregion



#region ________________________ runtime ________________________________
var counter:= 0
#endregion



var current_state: StateBase = null
var previous_state: StateBase = null  # Nuevo: guardar estado anterior

#endregion

func _ready():
	current_state = default_state
	
	#player_sprite = get_parent().player_sprite
	#player_collision = get_parent().player_collision
	_state_start()

func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)

func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)

func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)

func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)

func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)

func _state_start() -> void:
	print("StateMachine:", controlled_node.name,)
	prints( "-->", "start state:", current_state.name)
	
	#print(counter)
	
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()
	 
func _change_to(new_state: String) -> void:
	if current_state and current_state.has_method("end"): 
		current_state.end()
	
	# Guardar el estado anterior antes de cambiar

	previous_state = current_state
	current_state = get_node(new_state)
	if animation_player.current_animation != current_state.name:
		if String(current_state.name).begins_with("StateAttack"):
			animation_player.play("StateAttack")
			print("ATTACK!")
		elif animation_player.has_animation(current_state.name):
			animation_player.play(current_state.name)
		elif animation_player.has_animation(fallback_animation):
			animation_player.play(fallback_animation)
		else:
			push_warning("Neither state animation '%s' nor fallback '%s' found." % [current_state.name, fallback_animation])
			
	_state_start()
