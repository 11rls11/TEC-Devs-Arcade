extends CharacterBody2D







#region ________________________ on ready  ___________________________
@onready var player_sprite: AnimatedSprite2D = $Animated_superior
@onready var player_collision: CollisionShape2D = $Collision_superior



#region ________________________ runtime ________________________________


#endregion

func _ready() -> void:
	pass

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var direction := Input.get_axis("ui_left", "ui_right")
	


	# Handle jump.
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	move_and_slide()

func _ground_state(direction,delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * ground_speed, ground_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ground_speed)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		_perform_jump(JUMP_VELOCITY)
	pass

func _air_state(direction,delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * air_speed, air_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_released("ui_accept"):
		
		velocity.y = JUMP_VELOCITY / 6
	pass

func _perform_jump(jump):
	velocity.y += jump
	_change_state(State.AIR)


func _change_state(new_state: State) -> void:
	
	if current_state == new_state:
		return

	current_state = new_state
	

	match new_state:
		State.GROUND:
			pass	
			
			
