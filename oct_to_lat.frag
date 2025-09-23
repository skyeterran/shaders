#version 330 core

uniform sampler in_tex;

in vec2 uv;
out vec4 color;

// Converts a latlong UV to a direction
vec3 lat_to_dir(vec2 lat) {
    float pi = 3.14159265359;
    float pi_half = 1.57079633;
    vec2 t = ((lat * 2.0) - vec2(1.0)) * vec2(pi, pi_half);
    return vec3(
        -cos(t.y) * sin(t.x),
        cos(t.y) * cos(t.x),
        sin(t.y)
    );
}

// Converts a direction to an octahedral UV
vec2 dir_to_oct(vec3 dir) {
    dir /= abs(dir.x) + abs(dir.y) + abs(dir.z);
    vec2 k = vec2(
        dir.x > 0.0 ? 1.0 : -1.0,
        dir.y > 0.0 ? 1.0 : -1.0
    );
    k *= 1.0 - abs(dir.yx);
    return (dir.z > 0.0 ? k : dir.xy) * 0.5 + 0.5;
}

void main() {
    color = texture(in_tex, dir_to_oct(lat_to_dir(uv)));
}
