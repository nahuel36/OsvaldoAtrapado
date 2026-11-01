extends Node2D

@export var lvl_select_button:MenuButton
@export var lvl_select_panel:Panel
@export var lvls_buttons:Control

func _ready() -> void:
	var save_node = (get_tree().get_nodes_in_group("Persist")[0] as Persist)
	save_node.load_game()
	if(save_node.progress > 0):
		lvl_select_button.visible = true	
	var i:int = 1
	for child in lvls_buttons.get_children():
		if(i <= save_node.progress+1):
			(child as MenuButton).visible = true
			(child as MenuButton).pressed.connect(gotoLevel.bind(i))
		i+=1
		
func showLevelSelectMenu():
	lvl_select_panel.visible = true

func hideLevelSelectMenu():
	lvl_select_panel.visible = false

func gotoLevel(level:int) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scene/Levels/lvl" + str(level) + ".tscn")


func _on_menu_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scene/Lore/Intro.tscn")
