
class_name GameManager extends Node

var score = 0

signal OnPointAdded(int)
const MAX_LVL = 5;

func add_point():
	score+=1
	OnPointAdded.emit(score)


func _on_finish_body_entered(body: Node2D) -> void:
	changeToNextScene()

func _on_area_2d_body_entered(body: Node2D) -> void:
	changeToNextScene()
		
func changeToNextScene()-> void:
	var actualLevelNumer:int = get_tree().current_scene.scene_file_path.lstrip("res://scene/Levels/lvl").rstrip(".tscn").to_int()	
	if(actualLevelNumer < MAX_LVL):
		var nextLevelString:String = str(actualLevelNumer+1)
		get_tree().call_deferred("change_scene_to_file", "res://scene/Levels/lvl" + nextLevelString + ".tscn") 
	else:
		get_tree().call_deferred("change_scene_to_file", "res://scene/Lore/End.tscn") 
