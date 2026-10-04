extends Node2D

#region _____________________ exports _________________________________________

@export_category("movement")
@export var Speed: int
@export var accel: float
@export var base_distance : int
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
			queue_free()
	if  abs(origin.x - global_position.x) >= base_distance:
		returning = true
		
		


	global_position += velocity



func get_to_point(delta, direction):
	
	velocity.x =  direction.x * Speed

func after_point(delta, direction):
	
	var target_direction : Vector2 = (return_to - global_position).normalized()
	#print(target_direction)

	var target_angle : float = fposmod(target_direction.angle() * sign(target_direction.x),  6.28319) * sign(target_direction.x)
	#print(target_angle)

	facing_direction.rotation = move_toward(facing_direction.rotation, target_angle, (rot_accel) * delta)
	#print(facing_direction.rotation)

	
	velocity.y = move_toward(velocity.y, direction.y * Speed, accel * 1000 * delta)
	velocity.x = move_toward(velocity.x, direction.x * Speed, accel  * 1000 * delta)
