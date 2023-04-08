uniform float uTime;
uniform float uDistortionFrequency;
uniform float uDistortionStrength;
uniform float uDisplacementFrequency;
uniform float uDisplacementStrength;

varying vec3 vNormal;
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
  vec4 displacedPosition = getDisplacedPosition(position);

  vec4 viewPosition = viewMatrix * vec4(displacedPosition.xyz, 1.0);
  vec4 projectedPosition = projectionMatrix * viewPosition;
  gl_Position = projectedPosition;

  vNormal = normal;
  vPerlinStrength = displacedPosition.a;
}