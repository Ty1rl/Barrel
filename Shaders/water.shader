shader_type spatial;
render_mode blend_mix, specular_phong;

uniform float speed : hint_range(-1,1) = 0.0;

//colors
uniform sampler2D noise1;
uniform sampler2D noise2;
uniform sampler2D normalmap : hint_normal;
uniform vec4 color : hint_color;

//waves
uniform vec2 strengh = vec2(0.5, 0.25);
uniform vec2 frequency = vec2(12.0, 12.0);
uniform vec2 time_scale = vec2(1.0, 2.0);


float waves(vec2 pos, float time){
	return (strengh.y * sin(pos.y * frequency.y + time * time_scale.y)) + (strengh.x * sin(pos.x * frequency.x + time * time_scale.x));
}


void vertex(){
	VERTEX.y += waves(VERTEX.xy, TIME);
}


void fragment(){
	float time = TIME * speed;
	vec3 n1 = texture(noise1, UV + time).rgb;
	vec3 n2 = texture(noise2, UV - time * 0.2).rgb;
	
	vec2 uv_movement = UV * 4.0;
	uv_movement += TIME * speed * 4.0;
	
	float sum = (n1.r + n2.r) - 1.0;
	
	float fin = 0.0;
	if (sum > 0.0 && sum < 0.4) fin = 0.1;
	if (sum > 0.4 && sum < 0.8) fin = 0.0;
	if (sum > 0.8) fin = 1.0;
	
	ALBEDO = vec3(fin) + color.rgb;
	
	NORMALMAP = texture(normalmap, uv_movement).rgb;
	ROUGHNESS = 0.1;
	SPECULAR = 1.0;
}