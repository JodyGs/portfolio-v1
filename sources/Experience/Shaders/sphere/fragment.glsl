varying vec3 vNormal;
varying float vPerlinStrength;

void main(){
  float test = dot(vNormal, vec3(0.0, -1.0, 1.0));
  float temp = vPerlinStrength + 0.5;
  temp *= 0.5;
  gl_FragColor = vec4(temp, temp, temp, 1.0);
}