#pragma header

uniform float iTime;
void mainImage(out vec4 fragColor, in vec2 fragCoord){
  vec2 uv = fragCoord.xy / openfl_TextureSize.xy;
  vec2 rectMin = vec2(0.0,0.0); vec2 rectMax = vec2(1.0,1.0);
  vec2 center = (rectMin+rectMax)*0.5; vec2 halfSize = center-rectMin; vec2 dist = abs(uv-center);
  float col = 0.0; float thickness = 2.0;
  if (all(lessThan(dist, halfSize)) && any(greaterThan(dist, halfSize - fwidth(uv)*thickness))) {
    vec2 pixel = fragCoord.xy; float aspect = halfSize.y/halfSize.x;
    float dir = (dist.x*aspect > dist.y) ? -sign(uv.x-center.x) : sign(uv.y-center.y);
    float dash = step(0.5, fract((pixel.x+pixel.y)*dir/50.0 + iTime));
    col = mix(1.0,0.0,dash);
  }
  fragColor = vec4(col,col,col,col);
}
void main(){ mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize); }
