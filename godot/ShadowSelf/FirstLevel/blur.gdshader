shader_type canvas_item;

uniform float amount: hint_range(0.0, 5.0);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV, amount);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
