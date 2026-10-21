shader_type canvas_item;

uniform float segments = 6;
uniform float zoom = 2;
uniform float tightness = 1;
uniform sampler2D sct : hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 cuv = (SCREEN_UV-.5)*2.; //centered uv
	float rad = length(cuv)*zoom;
	float ang = atan(cuv.y, cuv.x)*segments/TAU;
	vec4 sample = texture(sct, UV + vec2(ang,rad+ang));
	COLOR = sample;
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
