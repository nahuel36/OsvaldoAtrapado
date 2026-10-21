
shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;

uniform vec2 swirl_center = vec2(0.5, 0.5);
uniform float swirl_radius : hint_range(0.05, 1.0) = 0.5;
uniform float twist_strength : hint_range(-20.0, 20.0) = 8.0;
uniform float effect_amount : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // Coordenadas de pantalla relativas al centro del remolino.
    vec2 centered_uv = SCREEN_UV - swirl_center;

    float dist = length(centered_uv);
    float angle = atan(centered_uv.y, centered_uv.x);

    // El giro disminuye progresivamente hacia el borde.
    float radius_mask = 1.0 - smoothstep(
        0.0, swirl_radius, dist
    );

    float twist = twist_strength
        * radius_mask
        * effect_amount;

    // Volvemos a calcular las coordenadas giradas.
    float distorted_angle = angle + twist;

    vec2 distorted_uv = swirl_center
        + vec2(cos(distorted_angle), sin(distorted_angle)) * dist;

    // Leemos la escena con las coordenadas deformadas.
    COLOR = texture(screen_texture, distorted_uv);
}
