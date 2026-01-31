shader_type canvas_item;
uniform bool active = true;
void vertex() {
	COLOR =  vec4(1.1, 1.1, 1.1, 1.0);
}
float is_solid(float value){
	return max(0,sign(value));
}
float solidNeighbours(sampler2D sample,vec2 cords,vec2 pixel_size){
	float sum_alpha = texture(sample,cords+vec2(1,0)*pixel_size).a +
				texture(sample,cords+vec2(-1,0)*pixel_size).a +
				texture(sample,cords+vec2(0,1)*pixel_size).a +
				texture(sample,cords+vec2(0,-1)*pixel_size).a;
	
	return is_solid(sum_alpha);
}
void fragment() {
	if(COLOR.a == 0.0 && active){
		COLOR = vec4(0.7,0.7,0.7,solidNeighbours(TEXTURE,UV,TEXTURE_PIXEL_SIZE));
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
