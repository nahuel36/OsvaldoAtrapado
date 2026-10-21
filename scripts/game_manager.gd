
class_name GameManager extends Node

var score = 0

@export var next_level:String = "res://scene/game_lvl2.tscn"
signal OnPointAdded(int)

func add_point():
	score+=1
	OnPointAdded.emit(score)


func _on_finish_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file(next_level) # Replace with function body.
