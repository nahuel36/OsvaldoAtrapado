extends Node2D

func _ready() -> void:
	var save_node = (get_tree().get_nodes_in_group("Persist")[0] as Persist)
	save_node.load_game()	


func _on_menu_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scene/Lore/Intro.tscn")
