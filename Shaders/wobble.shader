shader_type spatial;
render_mode depth_draw_opaque, unshaded, world_vertex_coords;

uniform vec4 color : hint_color;

uniform float amount : hint_range(0, 1, 0.01) = 0.02;
uniform float speed : hint_range(0, 50) = 3;
uniform float frequency : hint_range(0, 10, .1) = 2.87;

void vertex() {
    VERTEX.x += sin(VERTEX.y * frequency + round(TIME * speed)) * amount;
    VERTEX.y += sin(VERTEX.x * frequency + round(TIME * speed)) * amount;
    VERTEX.z += sin(VERTEX.y * frequency + round(TIME * speed)) * amount;
}

void fragment() {
	ALBEDO = color.rgb;
}