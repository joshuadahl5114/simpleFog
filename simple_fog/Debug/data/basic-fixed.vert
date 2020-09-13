#version 150

uniform mat4 projection_matrix;
uniform mat4 modelview_matrix;
uniform mat3 normal_matrix;

uniform vec4 material_ambient;
uniform vec4 material_diffuse;
uniform vec4 material_specular;
uniform vec4 material_emissive;
uniform float material_shininess;

uniform float fog_start;
uniform float fog_end;
uniform float fog_density;
uniform vec4 fog_color;
uniform int fog_type;

struct light {
	vec4 position;
	vec4 diffuse;
	vec4 specular;
	vec4 ambient;
};

uniform light light0;

in vec3 a_Vertex;
in vec2 a_TexCoord0;
in vec3 a_Normal;

out vec4 color;
out vec2 texCoord0;
out float blendFactor;

void main(void) 
{
	vec3 N = normalize(normal_matrix * a_Normal);	
	vec3 L = normalize(modelview_matrix * light0.position).xyz;
	float NdotL = max(dot(N, L.xyz), 0.0);
	vec4 pos = modelview_matrix * vec4(a_Vertex, 1.0);
	
	vec3 E = -pos.xyz;
	vec4 finalColor = material_ambient * light0.ambient;

	if (NdotL > 0.0) 
	{
		vec3 HV = normalize(L + E);
		float NdotHV = max(dot(N, HV), 0.0);
		finalColor += material_specular * light0.specular * pow(NdotHV, material_shininess);	
		finalColor += material_diffuse * light0.diffuse * NdotL;
	}

	//depending on the fog type we either use the linear, exp or exp2 calculations
	//to calculate the fog blend factor
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
	
	color = material_emissive + finalColor;
	texCoord0 = a_TexCoord0;
	gl_Position = projection_matrix * pos;	
}

