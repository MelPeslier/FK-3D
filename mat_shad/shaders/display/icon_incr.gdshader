shader_type canvas_item;

global uniform vec4 bad;
global uniform vec4 good;

uniform float coef: hint_range(0.0, 1.0);

void fragment() {
	COLOR.rgb = mix(bad, good, coef).rgb;
}
