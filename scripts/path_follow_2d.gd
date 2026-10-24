extends PathFollow2D

@export var objectToMove:Node2D
var actualProg
@onready var path_follow_2d: PathFollow2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	actualProg = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	actualProg += delta 
	progress_ratio = pingpong(actualProg,1) 
	objectToMove.position = path_follow_2d.position
