
extends ColorRect

@export var swirl_anchor: Marker2D

func _process(_delta: float) -> void:
	var mat := material as ShaderMaterial

	if mat == null or swirl_anchor == null:
		return

	var screen_position: Vector2 = (
		get_viewport().get_canvas_transform()
		* swirl_anchor.global_position
	)

	mat.set_shader_parameter(
		"swirl_center",
		screen_position / get_viewport_rect().size
	)

	mat.set_shader_parameter(
		"viewport_size",
		get_viewport_rect().size
	)
