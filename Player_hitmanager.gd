extends Node
var camera: Camera2D 


const shake_fade: float = 10.0



var min_offset = -200
var max_offset = 200

var _shake_strength := 0.0
# Called when the node enters the scene tree for the first time.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_get_camera()
	get_tree().scene_changed.connect(_get_camera)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _get_camera():
	print("camara not found")
	camera = get_viewport().get_camera_2d()
	if camera:
		print("Found active camera: ", camera.name)
	else:
		print("camara not found")

func _trigger_shake(strength):
	_shake_strength = strength

func _process(delta: float) -> void:
	
		
	if _shake_strength > 0:
		if not camera:
			print("no camera")
			return
		Engine.time_scale = _shake_strength * 0.1
		
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		camera.offset = Vector2(camera.offset.x + randf_range(-_shake_strength*10, _shake_strength*10), camera.offset.y + randf_range(-_shake_strength*10, _shake_strength*10))
		
		await get_tree().create_timer(0.12, true, false, true).timeout
		Engine.time_scale = 1
	
	_shake_strength = 0.0
