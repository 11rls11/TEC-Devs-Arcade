extends Node2D

#region _____________________ exports _________________________________________



@export_category("movement")
@export var Speed: int
@export var accel: float
@export var base_distance : int
@export var elapsedTimeAfter = 0
@export var rot_accel : float

@export_category("other")
@export var has_returned_range : float


#endregion

#region ______________________ onreadies ______________________________________


@onready var facing_direction: RayCast2D = $direction

#endregion

#region _______________________ runtime ______________________________________

var facing : float
var return_to : Vector2
var velocity : Vector2
var origin : Vector2
var returning := false
var base_rot : float
var caller_group : String
var caller : CharacterBody2D

#endregion

func _ready() -> void:
	returning = false
	facing_direction.rotation = base_rot
	print(base_rot)
	origin = global_position
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not caller:
		caller = get_tree().get_first_node_in_group(caller_group)
		print(caller)


	var direction = (
	facing_direction.to_global(facing_direction.target_position)
	- facing_direction.global_position
).normalized()
	if returning == false:
		get_to_point(delta, direction)
	else:
		return_to = caller.global_position
		after_point(delta, direction)
		if (return_to - global_position).length() <= has_returned_range:
			_on_return()
	if  abs(origin.x - global_position.x) >= base_distance:
		returning = true
		
		


	global_position += velocity



func get_to_point(delta, direction):
	elapsedTimeAfter = 0
	velocity.x =  direction.x * Speed

func after_point(delta, direction):
	if !Input.is_action_pressed("throw"):
		var target_direction : Vector2 = (return_to - global_position).normalized()
		#print(target_direction)

		var target_angle : float = fposmod(target_direction.angle() * sign(target_direction.x),  6.28319) * sign(target_direction.x)
		#print(target_angle)

		facing_direction.rotation = move_toward(facing_direction.rotation, target_angle, (rot_accel) * delta)
		#print(facing_direction.rotation)

		
		velocity.y = move_toward(velocity.y, direction.y * Speed, accel * 1000 * delta)
		velocity.x = move_toward(velocity.x, direction.x * Speed, accel  * 1000 * delta)
		#print(velocity)
	elif elapsedTimeAfter > 1.5:
		var target_direction : Vector2 = (return_to - global_position).normalized()
		var target_angle : float = fposmod(target_direction.angle() * sign(target_direction.x),  6.28319) * sign(target_direction.x)
		#print(target_angle)

		facing_direction.rotation = move_toward(facing_direction.rotation, target_angle, (rot_accel) * delta)
		#print(facing_direction.rotation)

		
		velocity.y = move_toward(velocity.y, direction.y * Speed, accel * 1000 * delta)
		velocity.x = move_toward(velocity.x, direction.x * Speed, accel  * 1000 * delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0.0, delta*9)

func _on_return():
	if global_position.y > return_to.y:
		var caller_machine = caller.get_node("StateMachine")
		caller_machine._change_to("State_suitcase_bounce")
	queue_free()

func _on_contact(body):
	var body_machine = body.get_node("StateMachine_e")
	body_machine._change_to("StateGetFucked")
	#body.position.y += -0.1
	print(velocity)
	body.velocity = velocity * 10 + Vector2(0.0, -300)
	returning = true
	var turn_angle_to_vector = Vector2.from_angle(facing_direction.rotation)
	var bouncer = turn_angle_to_vector.bounce(facing_direction.get_collision_normal())
	
	facing_direction.rotation =  fposmod( bouncer.angle() * sign(bouncer.x),  6.28319) * sign(bouncer.x)
	velocity *= -bouncer
	#print(velocity)
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		_on_contact(body)
	pass # Replace with function body.
