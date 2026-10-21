
shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform vec2 swirl_center = vec2(0.75, 0.5);
uniform vec2 viewport_size = vec2(1152.0, 648.0);

uniform float swirl_radius = 300.0;
uniform float twist_strength = 8.0;
uniform float effect_amount : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec2 screen_pos = SCREEN_UV * viewport_size;
    vec2 center_pos = swirl_center * viewport_size;

    vec2 delta = screen_pos - center_pos;
    float dist = length(delta);

    float mask = 1.0 - smoothstep(0.0, swirl_radius, dist);
    float angle = atan(delta.y, delta.x);

    float twist = twist_strength * mask * effect_amount;
    float distorted_angle = angle + twist;

    vec2 distorted_pos = center_pos + vec2(
        cos(distorted_angle),
        sin(distorted_angle)
    ) * dist;

    vec2 distorted_uv = distorted_pos / viewport_size;

    COLOR = texture(screen_texture, distorted_uv);
}
