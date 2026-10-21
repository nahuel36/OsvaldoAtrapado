
class_name GameManager extends Node

var score = 0

@export var level_score:int 
@export var next_level:String = "res://scene/game_lvl2.tscn"
signal OnPointAdded(int)

func add_point():
	score+=1
	OnPointAdded.emit(score)
	if score >= level_score:
		score = 0
		get_tree().change_scene_to_file(next_level)
