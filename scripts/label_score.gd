extends Node2D

@onready var label_score: Label = $LabelScore


func _on_game_manager_on_point_added(score: int) -> void:
	label_score.text = "You collected " + str(score) + " coins."
