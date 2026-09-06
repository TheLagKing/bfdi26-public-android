#pragma header

float pi = 6.28318530718;

uniform float directions;
uniform float quality;
uniform float size;
uniform float merge;
uniform float bruh;

void main()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 radius = size / openfl_TextureSize.xy;

    vec4 color = texture2D(bitmap, uv);

    float dirStep = pi / directions;
    float qualityStep = 1.0 / quality;

    for (float d = 0.0; d < pi; d += dirStep)
    {
        for (float i = qualityStep; i < 1.001; i += qualityStep)
        {
            vec2 offset = vec2(cos(d), sin(d) * 2.0) * radius * i;
            color += texture2D(bitmap, uv + offset);
        }
    }

    color /= (quality * directions + 1.0);

    gl_FragColor = color * bruh;
}
