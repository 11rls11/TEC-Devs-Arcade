extends CharacterBody2D

const ground_drag := 100.0

var got_fucked := false
var dissapear := false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if got_fucked == true:
		print("get fucked idiot")
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0 , (ground_drag * 1000) * delta )
		velocity.y = 0
		if dissapear == true:
			queue_free()
		
	else:
		velocity.y += gravity * delta
		if got_fucked == true:
			dissapear = true
			
	

	move_and_slide()
