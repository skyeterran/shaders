#version 330 core

uniform sampler in_tex;

in vec2 uv;
out vec4 color;

// Converts an octahedral UV to a direction
vec3 oct_to_dir(vec2 oct) {
    oct = oct * -2.0 + 1.0;
    vec3 dir = vec3(oct.x, oct.y, 1.0 - abs(oct.x) - abs(oct.y));
    float t = clamp(-dir.z, 0.0, 1.0);
    dir.x += dir.x >= 0.0 ? -t : t;
    dir.y += dir.y >= 0.0 ? -t : t;
    dir = vec3(-dir.y, dir.x, dir.z);
    return normalize(dir);
}

// Converts a direction to a latlong UV
vec2 dir_to_lat(vec3 dir) {
    float inv_pi = 0.318309886;
    return vec2(
        (atan(dir.y, dir.x) * inv_pi + 1.0) * 0.5,
        acos(dir.z) * inv_pi
    );
}

void main() {
    color = texture(in_tex, dir_to_lat(oct_to_dir(uv)));
}
