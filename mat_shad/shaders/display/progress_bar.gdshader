shader_type canvas_item;

uniform float stroke_size;

uniform float value;

uniform vec4 front_color: source_color;
uniform vec4 back_color: source_color;
uniform vec4 thresholds_color: source_color;

uniform float thresh_1;
uniform float thresh_2;
uniform float thresh_3;

float stroke(float edge, float where, float size){
	return step(edge, where + size * 0.5) - step(edge, where - size * 0.5);
}

void fragment() {
	vec4 tex = texture( TEXTURE, UV);
	
	float thresholds = 0.0;
	
	if (thresh_1 > 0.001){
		thresholds += stroke(thresh_1, UV.x, stroke_size);
	}	
	if (thresh_2 > 0.001){
		thresholds += stroke(thresh_2, UV.x, stroke_size);
	}	
	if (thresh_3 > 0.001){
		thresholds += stroke(thresh_3, UV.x, stroke_size);
	}
	
	thresholds = clamp(thresholds, 0.0, 1.0);
	
	float front_area = step(UV.x, value) - thresholds;
	front_area = clamp(front_area, 0.0, 1.0);
	float back_area = step(value, UV.x) + thresholds;
	back_area = clamp(back_area, 0.0, 1.0);
	
	vec4 final_output = front_area * front_color + back_area * back_color + thresholds * thresholds_color ;
	
	COLOR.rgb = final_output.rgb;
}
