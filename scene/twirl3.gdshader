
shader_type canvas_item;

uniform sampler2D screen_texture
    : hint_screen_texture, repeat_disable;

uniform sampler2D portal_noise_texture : repeat_enable;

uniform vec2 swirl_center = vec2(0.75, 0.5);
uniform vec2 viewport_size = vec2(1152.0, 648.0);

uniform float swirl_radius : hint_range(50.0, 800.0) = 300.0;
uniform float twist_strength : hint_range(-15.0, 15.0) = 8.0;
uniform float effect_amount : hint_range(0.0, 1.0) = 1.0;

uniform float speed = 0.3;
uniform float power_strength : hint_range(0.1, 5.0) = 1.0;

uniform vec3 portal_dark_color : source_color =
    vec3(0.15, 0.0, 0.3);

uniform vec3 portal_bright_color : source_color =
    vec3(0.3, 0.9, 1.0);

uniform vec3 rim_color_source : source_color =
    vec3(0.5, 0.1, 1.0);

uniform float rim_color_strength = 2.0;

void fragment() {
    // 1. Posición del píxel y centro del remolino.
    vec2 screen_pos = SCREEN_UV * viewport_size;
    vec2 center_pos = swirl_center * viewport_size;

    vec2 delta = screen_pos - center_pos;
    float dist = length(delta);

    float radial = dist / swirl_radius;
    float angle = atan(delta.y, delta.x);

    // 2. Distorsión real de la escena.
    float distortion_mask = 1.0 - smoothstep(
        0.0, 1.0, radial
    );

    float twist = twist_strength
        * distortion_mask
        * effect_amount;

    float distorted_angle = angle + twist;

    vec2 distorted_pos = center_pos + vec2(
        cos(distorted_angle),
        sin(distorted_angle)
    ) * dist;

    vec2 distorted_uv = distorted_pos / viewport_size;

    vec3 scene_color = texture(
        screen_texture, distorted_uv
    ).rgb;

    // 3. Coordenadas polares para el dibujo del portal.
    float angle_remap = angle / (2.0 * PI) + 0.5;

    vec2 polar_uv = vec2(
        angle_remap + radial * 0.8,
        radial * 1.5
    );

    // 4. Ruido animado.
    float noise_value = texture(
        portal_noise_texture,
        polar_uv + vec2(TIME * speed, -TIME * speed * 0.5)
    ).r;

    noise_value = pow(
        max(noise_value, 0.001),
        power_strength
    );

    float noise_mask = smoothstep(
        0.35, 0.65, noise_value
    );

    vec3 portal_color = mix(
        portal_dark_color,
        portal_bright_color,
        noise_mask
    );

    // 5. Máscara circular y hueco central.
    float circle_mask = 1.0 - smoothstep(
        0.92, 1.0, radial
    );

    float center_hole_mask = smoothstep(
        0.08, 0.22, radial
    );

    float portal_mask = circle_mask * center_hole_mask;

    // 6. Borde luminoso.
    float rim_outer = smoothstep(
        0.78, 0.94, radial
    );

    float rim_inner = 1.0 - smoothstep(
        0.94, 1.0, radial
    );

    float rim_mask = rim_outer * rim_inner;

    vec3 portal_rgb = portal_color * center_hole_mask
        + rim_mask * rim_color_source * rim_color_strength;

    // 7. Combinamos el portal con la escena deformada.
    float portal_alpha = circle_mask
        * max(noise_value * 0.75, rim_mask)
        * effect_amount;

    portal_alpha = clamp(portal_alpha, 0.0, 1.0);

    vec3 final_color = mix(
        scene_color,
        portal_rgb,
        portal_alpha
    );

    COLOR = vec4(final_color, 1.0);
}
