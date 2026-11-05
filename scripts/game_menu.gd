extends CanvasLayer

@export var node: Control



func _on_continue_pressed() -> void:
	node.visible = false

func _on_back_to_menu_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scene/MainMenu.tscn") 


func _on_menu_button_pressed() -> void:
	node.visible = true
