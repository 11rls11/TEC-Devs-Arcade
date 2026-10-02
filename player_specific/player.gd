extends CharacterBody2D







#region ________________________ on ready  ___________________________
@onready var player_sprite: AnimatedSprite2D = $Animated_superior
@onready var player_collision: CollisionShape2D = $Collision_superior

#endregion

#region ________________________ runtime ________________________________


#endregion

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	


	# Handle jump.
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	move_and_slide()
