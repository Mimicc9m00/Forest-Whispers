shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float time;

void fragment() {
	vec2 uv = SCREEN_UV;

	// scanlines mais fracas
	float scan = sin(uv.y * 600.0 + time * 8.0) * 0.01;

	// chromatic aberration bem leve
	float offset = 0.0012;

	float r = texture(SCREEN_TEXTURE, uv + vec2(offset, 0.0)).r;
	float g = texture(SCREEN_TEXTURE, uv).g;
	float b = texture(SCREEN_TEXTURE, uv - vec2(offset, 0.0)).b;

	vec3 color = vec3(r, g, b);

	// noise mais fraco
	float noise = fract(sin(dot(uv + time, vec2(12.9898,78.233))) * 43758.5453);
	color += noise * 0.015;

	// scanlines suaves
	color -= scan;

	COLOR = vec4(color, 1.0);
}