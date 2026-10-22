extends AudioStreamPlayer2D

@onready var music: AudioStreamPlayer2D = $"."
# Called when the node enters the scene tree for the first time.
@onready var menumusic: AudioStreamPlayer2D = $menumusic

func _ready() -> void:
		get_tree().scene_changed.connect(_on_scene_changed)
		menumusic.play();

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_scene_changed() -> void:
	if get_tree().current_scene.name == "MainMenu" ||   get_tree().current_scene.name == "Intro":
		music.stop()
		if not menumusic.playing:
			menumusic.play()
	else:
		menumusic.stop()
		if not music.playing:
			music.play()
		
