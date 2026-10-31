extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func introEnded()-> void:
	get_tree().call_deferred("change_scene_to_file", "res://scene/Levels/lvl1.tscn")
