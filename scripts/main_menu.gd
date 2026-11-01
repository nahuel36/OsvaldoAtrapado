extends Node2D

func _on_menu_button_pressed() -> void:
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node:Persist in save_nodes:
		print(node.MAX_LEVELS)
	get_tree().call_deferred("change_scene_to_file", "res://scene/Lore/Intro.tscn")
