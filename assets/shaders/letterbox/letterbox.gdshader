shader_type canvas_item;

uniform float width : hint_range(0.0, 1.0) = 0.1;
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	float top = step(width, SCREEN_UV.y);
	float bottom = step(width, 1.0 - SCREEN_UV.y);
	
    COLOR = color * (1.0 - top * bottom);
}