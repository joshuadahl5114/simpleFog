#version 150

uniform sampler2D texture0;
uniform vec4 fog_color;

in vec4 color;
in vec2 texCoord0;
in float blendFactor;

out vec4 outColor;

void main(void) {
	vec4 fragColor = color * texture(texture0, texCoord0.st);	
	outColor = mix(fog_color, fragColor, blendFactor);
}
