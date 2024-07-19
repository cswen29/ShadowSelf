shader_type canvas_item;

uniform sampler2D noiseTexture: repeat_enable;
uniform vec2 scroll_up = vec2(-4, 2);
uniform vec2 scroll_down = vec2(4, -2);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform float distortion_strength : hint_range(-1.0, 1) = 0.005;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 noise = texture(noiseTexture, UV + scroll_up * (TIME*2.0)) *
        			texture(noiseTexture, UV + scroll_down * (TIME*2.0));
					
	  vec4 screen_col = texture(SCREEN_TEXTURE, SCREEN_UV +  (distortion_strength * cos(TIME) * noise.gg));
	  COLOR = screen_col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
