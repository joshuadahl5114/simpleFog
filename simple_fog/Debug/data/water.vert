#version 150

uniform mat4 projection_matrix;
uniform mat4 modelview_matrix;
uniform mat3 normal_matrix;

uniform float fog_start;
uniform float fog_end;
uniform float fog_density;
uniform vec4 fog_color;
uniform int fog_type;

in vec3 a_Vertex;
in vec2 a_TexCoord0;

out vec4 color;
out vec2 texCoord0;
out float blendFactor;

void main(void) 
{
	vec4 pos = modelview_matrix * vec4(a_Vertex, 1.0);
	
	if (fog_type == 0) 
	{
		blendFactor = clamp((fog_end - length(pos)) / (fog_end - fog_start), 0.0, 1.0);
	} 
	else if (fog_type == 1) 
	{
		blendFactor = exp(-fog_density * length(pos));
	} 
	else 
	{
		blendFactor = exp2(-fog_density * length(pos));
	}

	color = vec4(1.0f, 1.0f, 1.0f, 0.3f);
	texCoord0 = a_TexCoord0;
	gl_Position = projection_matrix * pos;	
}
