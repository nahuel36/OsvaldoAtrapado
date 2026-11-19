
extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@export var swirl_portal: Marker2D
var mat:ShaderMaterial;

func _process(_delta: float) -> void:
	mat = color_rect.material

	if mat == null or swirl_portal == null:
		return

	# Convertimos la posición del portal del mundo
	# a coordenadas del viewport.
	var screen_position: Vector2 = (
		get_viewport().get_canvas_transform()
		* swirl_portal.global_position
	)

	mat.set_shader_parameter(
		"swirl_center",
		screen_position / color_rect.get_viewport_rect().size
	)

	mat.set_shader_parameter(
		"viewport_size",
		color_rect.get_viewport_rect().size
	)
