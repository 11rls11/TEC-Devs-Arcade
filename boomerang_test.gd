extends Node

@export var suitcase : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("throw"):
		var boomerang = suitcase.instantiate()
		boomerang.base_rot = 0
		get_tree().current_scene.add_child(boomerang)
		
