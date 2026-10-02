#credit goes to Rodrick.tscn for this(it isnt necesary to credit me, but its greatly appreacited)
extends Node
var Music : AudioStreamPlayer
var music_bus = AudioServer.get_bus_index("Music")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Music = AudioStreamPlayer.new()
	add_child(Music)
	Music.bus = "Music"
	get_tree().scene_changed.connect(update_music)
	update_music()

func update_music():
	var scene = get_tree().current_scene

	if scene == null:
		return

	# Check if the scene has the variable
	if "current_theme" in scene:
		var theme = scene.current_theme
		print(theme)
	

		# Don't restart same music
		if  Music.stream == theme and Music.playing:
			print("no theme")
			
			return
	

		Music.stream = theme
		Music.play()
	else:
		print("no themes")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Music.stream == null:
		return
	if not Music.playing :
		Music.play()
		#print("restart tune")
	else:
		return
