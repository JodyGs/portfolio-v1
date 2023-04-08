uniform float uTime;
uniform float uDistortionFrequency;
uniform float uDistortionStrength;
uniform float uDisplacementFrequency;
uniform float uDisplacementStrength;

varying vec3 vNormal;
varying vec3 vColor;
varying float vPerlinStrength;

#pragma glslify: perlin4d = require('../partials/perlin4d.glsl')
#pragma glslify: perlin3d = require('../partials/perlin3d.glsl')

vec4 getDisplacedPosition(vec3 _position) {
  vec3 displacementPosition = _position;
  displacementPosition += perlin4d(vec4(displacementPosition * uDistortionFrequency, uTime)) * uDistortionStrength;

  float perlinStrength = perlin4d(vec4(displacementPosition * uDisplacementFrequency, uTime));

  vec3 displacedPosition = _position;
  displacedPosition += normalize(_position) * perlinStrength * uDisplacementStrength;

  return vec4(displacedPosition, perlinStrength);
}

void main() {

  // Position
  vec4 displacedPosition = getDisplacedPosition(position);

  vec4 viewPosition = viewMatrix * vec4(displacedPosition.xyz, 1.0);
  vec4 projectedPosition = projectionMatrix * viewPosition;
  gl_Position = projectedPosition;

  // Colors
  vec3 uLightAColor = vec3(1.0, 0.2, 0.5);
  vec3 uLightAPosition = vec3(1.0, 0.9, 0.0);
  float lightAIntensity = max(0.0, - dot(normal, normalize(- uLightAPosition)));
  
  vec3 uLightBColor = vec3(0.5, 0.2, 1.0);
  vec3 uLightBPosition = vec3(-1.0, -0.4, 0.0);
  float lightBIntensity = max(0.0, - dot(normal, normalize(- uLightBPosition)));

  vec3 color = vec3(0.0);
  color = mix(color, uLightAColor, lightAIntensity);
  color = mix(color, uLightBColor, lightBIntensity);

  vNormal = normal;
  vColor = color;
  vPerlinStrength = displacedPosition.a;
}