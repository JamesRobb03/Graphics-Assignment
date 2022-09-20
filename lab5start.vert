// Minimal fragment shader
// from AC41001 Lab 5
//James Robb Assignment 2 12/21
//edited for oren Nayar shading with textures

#version 400

// These are the vertex attributes
layout(location = 0) in vec3 position;
layout(location = 1) in vec4 colour;
layout(location = 2) in vec3 normal;
layout(location = 3) in vec2 texcoord;

// Uniform variables are passed in from the application
uniform mat4 model, view, projection;
uniform uint colourmode;
uniform mat3 normalmatrix;
uniform vec4 lightpos;

// Output the vertex colour - to be rasterized into pixel fragments
out vec2 ftexcoord;
out vec3 fnormal;
out vec3 flightdir, fposition;
out vec4 fdiffusecolour;


vec4 ambient = vec4(0.2, 0.2,0.2,1.0);

void main()
{
	//other program
	vec4 position_h = vec4(position, 1.0);	// Convert the (x,y,z) position to homogeneous coords (x,y,z,w)
	vec3 light_pos3 = lightpos.xyz;			

	// Switch the vertex colour based on the colourmode
	if (colourmode == 1)
		fdiffusecolour =  vec4(1.0, 1.0, 1.0, 1.0);
	else
		fdiffusecolour = vec4(0.2, 0.2, 0.2, 1.0);

	// Define our vectors for calculating diffuse and specular lighting
	mat4 mv_matrix = view * model;				// Calculate the model-view transformation
	fposition = (mv_matrix * position_h).xyz;	// Transform the vertex position (x, y, z) into eye-space
	fnormal = normalize(normalmatrix * normal);	// Modify the normal by the normal-matrix (i.e. transform to eye-space )
	flightdir = light_pos3 - fposition;			// Calculate the vector from the light position to the vertex in eye space
	ftexcoord = texcoord;
	// Calculate the vertex position in projection space and output to the pipleline using the reserved variable gl_Position
	gl_Position = (projection * view * model) * position_h;
}

