//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_worldPos;

varying mat3 v_rotationMatrix;

uniform sampler2D sl_NormalMap;

uniform float sl_SpriteAngle;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    v_worldPos = (gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos).xyz;
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    float cosAngle = cos(sl_SpriteAngle);
    float sinAngle = sin(sl_SpriteAngle);
    v_rotationMatrix[0][0] = cosAngle;
    v_rotationMatrix[1][1] = cosAngle;
    v_rotationMatrix[0][1] = sinAngle;
    v_rotationMatrix[1][0] = -sinAngle;
    v_rotationMatrix[1][2] = 0.0;
    v_rotationMatrix[2][1] = 0.0;
    v_rotationMatrix[2][2] = 1.0;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~// Sprite Lamp's basic shader, by Finn Morgan

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_worldPos;

varying mat3 v_rotationMatrix;

uniform sampler2D sl_NormalDepthMap;
uniform sampler2D sl_SpecGlossMap;
uniform sampler2D sl_AOMap;
uniform sampler2D sl_EmissiveMap;


uniform float sl_CelLevel;
uniform float sl_Shininess;
uniform float sl_WrapAroundLevel;
uniform float sl_AOStrength;
uniform float sl_EmissiveStrength;
uniform float sl_AmplifyDepth;

uniform vec3 sl_UpperAmbientColour;
uniform vec3 sl_LowerAmbientColour;


uniform vec3 sl_LightPos;
uniform vec2 sl_TextureRes;
uniform vec3 sl_LightColour;


void main()
{

    //All the texture lookups we need done up front (not counting lookups for shadowing).
    vec4 diffuseColour = texture2D (gm_BaseTexture, v_vTexcoord) * v_vColour;
    vec4 normalDepthColour = texture2D (sl_NormalDepthMap, v_vTexcoord);
    vec4 specGlossColour = texture2D (sl_SpecGlossMap, v_vTexcoord);
    vec4 aoColour = texture2D (sl_AOMap, v_vTexcoord);
    vec4 emissiveColour = texture2D (sl_EmissiveMap, v_vTexcoord);

    
    vec3 normal = normalDepthColour.rgb * 2.0 - 1.0;
    
    vec3 worldNormal = normal * v_rotationMatrix; //We need this for hemispheric ambience
    
    float ambientOcclusion = (aoColour.r * sl_AOStrength) + (1.0 - sl_AOStrength);
        
    float aspectRatio = sl_TextureRes.x / sl_TextureRes.y;
        
    //'upness' - 1.0 means the normal is facing straight up, 0.5 means horizontal, 0.0 straight down, etc.    
    float upness = worldNormal.y * 0.5 + 0.5;
    vec3 ambientColour = (sl_LowerAmbientColour * (1.0 - upness) + sl_UpperAmbientColour * upness) * ambientOcclusion * diffuseColour.rgb;
    
    ambientColour += emissiveColour.rgb * sl_EmissiveStrength;
    
    vec3 colourFromLights = vec3(0.0, 0.0, 0.0);
    //Everything in this block is calculations for an individual light. This is the bit that
    //has to be looped through and added together 
    
    {
        vec3 lightDirection = sl_LightPos - v_worldPos;
        float lightDistance = length(lightDirection);
        lightDirection = v_rotationMatrix * lightDirection; //We need the light direction in object space for shadow casting.
        lightDirection = normalize(lightDirection);
    
        //Start by calculating how much this is in shadow (1.0 meaning 'not in shadow at all' and 0.0 meaning 'fully in shadow')
        float shadowMult = 1.0;
                    
        vec3 moveVec = lightDirection.xyz * 0.006 * vec3(1.0, aspectRatio * -1.0, 1.0);
    
        float thisHeight = normalDepthColour.a * sl_AmplifyDepth;
        vec3 tapPos = vec3(v_vTexcoord, thisHeight + 0.1);
        //This loop traces along the light ray and checks if that ray is inside the depth map at each point.
        //If it is, darken that pixel a bit.
        for (int i = 0; i < 8; i++)
        {
            tapPos += moveVec;
            float tapDepth = texture2D(sl_NormalDepthMap, tapPos.xy).a * sl_AmplifyDepth;
            //phantomColour = texture2D(sl_NormalDepthMap, tapPos.xy).aaa;
            if (tapDepth > tapPos.z)
            {
                shadowMult -= 0.125;
            }
        }
        shadowMult = clamp(shadowMult, 0.0, 1.0);
        
        
        //Basic dot lighting.
        float normalDotLight = dot(normal, lightDirection);
        
        //Simple linear attenuation at the moment:
        float attenuation = 0.5 / lightDistance;
                
        //Slightly awkward maths for light wrap.
        float diffuseLevel = clamp(normalDotLight + sl_WrapAroundLevel, 
                0.0, sl_WrapAroundLevel + 1.0) / (sl_WrapAroundLevel + 1.0) * attenuation * shadowMult;
        
        // Compute specular part of lighting
        float specularLevel;
        if (normalDotLight < 0.0)
        {
            // Light is on the wrong side, no specular reflection
            specularLevel = 0.0;
        }
        else
        {
            // For the moment, since this is 2D, we'll say the view vector is always (0, 0, -1).
            //This isn't really true when you're not using a orthographic camera though. FIXME.
            vec3 viewDirection = vec3(0.0, 0.0, 1.0);
            specularLevel = attenuation * pow(max(0.0, dot(reflect(-lightDirection, normal),
                viewDirection)), sl_Shininess * specGlossColour.a);
        }
                
                
        // Add cel-shading if enough levels were specified
        if (sl_CelLevel >= 2.0)
        {
            diffuseLevel = floor(diffuseLevel * sl_CelLevel) / (sl_CelLevel - 0.5);
            specularLevel = floor(specularLevel * sl_CelLevel) / (sl_CelLevel - 0.5);
        }
            
        //float diffuseLevel = normalDotLight;
        vec3 diffuseComponent = diffuseLevel * diffuseColour.rgb * sl_LightColour;
        vec3 specularComponent = specularLevel * specGlossColour.rgb * sl_LightColour;
        colourFromLights += diffuseComponent;
        colourFromLights += specularComponent;
    }
    
    gl_FragColor = vec4(ambientColour + colourFromLights, diffuseColour.a);

}

