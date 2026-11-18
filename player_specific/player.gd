extends CharacterBody2D

#region ___________________________ exports _____________________________
@export_group("hp")
@export var Max_hp := 10
@export_group("damage")
@export var base_damage := 1
@export var push_force := Vector2(300, -300)





#region ________________________ on ready  ___________________________
@onready var player_sprite: AnimatedSprite2D = $Animated_superior
@onready var player_collision: CollisionShape2D = $Collision_superior
@onready var hitbox: Area2D = $hitbox
@onready var hitbox_box: CollisionShape2D = $hitbox/CollisionShape2D


#endregion

#region ________________________ runtime ________________________________
var dir := 1
var suitcase_out := false

var hp := 10

var current_damage = 0
#endregion


func _ready() -> void:
	current_damage = base_damage
	hp = Max_hp
	hitbox_box.disabled = true



func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	hitbox.position.x = abs(hitbox.position.x) * dir
	


	# Handle jump.
	
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	

	move_and_slide()





func _on_hitbox_body_entered(body: Node2D) -> void:
	print("hitting")
	if body.is_in_group("enemy"):
		print("HIT")
		var body_machine = body.get_node("StateMachine_e")
		body.HP -= current_damage
		PlayerHitmanager._trigger_shake(current_damage)
		body_machine._change_to("StateHit_e")
	#body.position.y += -0.1
		print(velocity)
		body.velocity = Vector2(push_force.x * dir, push_force.y)
