shader_type spatial;
render_mode blend_add, cull_disabled, shadows_disabled, unshaded;

instance uniform vec4 color : source_color;
instance uniform float alpha : hint_range(0.0, 1.0);

void fragment() {
	ALBEDO = color.rgb;
	ALPHA = alpha;
}
