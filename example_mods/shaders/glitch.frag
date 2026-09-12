#pragma header
vec2 fragCoord;
vec2 iResolution;
uniform float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

precision lowp int;
precision mediump float;

//"Random" function borrowed from The Book of Shaders: Random
float random ( vec2 xy )
{
    return fract( sin( dot( xy.xy, vec2(12, 78) ) ) );
}

float luminance(vec4 color)
{
    return ( (color.r * 0.3) + (color.g * 0.6) + (color.b * 0.1) ) * color.a;
}

// Returns the y coordinate of the first pixel that is brighter than the threshold
float getFirstThresholdPixel(vec2 xy, float threshold)
{
	float luma = luminance( texture( iChannel0, xy / iResolution.xy ) );

	//Looking at every sequential pixel is very resource intensive,
	//thus, we'll increment the inspected pixel by dividing the image height in sections,
	//and add a little randomness across the x axis to hide the division of said sections
    float increment = iResolution.y / (30.0 + (random( xy.xx ) * 6.0)); 

    //Check if the luminance of the current pixel is brighter than the threshold,
    //if not, check the next pixel
	while( luma <= threshold )
	{
		xy.y -= increment;
        if( xy.y <= 0.0 ) return 0.0;
		luma = luminance( texture( iChannel0, xy / iResolution.xy ) );
	}
    
	return xy.y;
}

//Puts 10 pixels in an array
void putItIn(vec2 startxy, float size, inout vec4 colorarray[10])
{
    vec2 xy;
    int j;
    
    for( j = 9; j >= 0; --j )
    {
        //Divide the line of pixels into 10 sections,
        //then store the pixel found at the junction of each section
        xy = vec2(startxy.x, startxy.y + (size / 9.0) * float(j));
        
        colorarray[j] = texture( iChannel0, xy / iResolution.xy );
    }
}

//An attempt at Bubble sort for 10 pixels, sorting them from darkest to brightest, top to bottom
void sortArray(inout vec4 colorarray[10])
{
    vec4 tempcolor;
    int j;
    int swapped = 1;
    
    while( swapped > 0 )
    {
        swapped = 0;
		for( j = 9; j > 0; --j )
    	{
        	if( luminance(colorarray[j]) > luminance(colorarray[j - 1]) )
        	{           
            	tempcolor = colorarray[j];
            	colorarray[j] = colorarray[j - 1];
            	colorarray[j - 1] = tempcolor;
            
            	++swapped;
        	}
    	}
    }
}

uniform float amount;
void mainImage()
{ 
    fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    iResolution = openfl_TextureSize;
	float firsty = getFirstThresholdPixel( vec2(fragCoord.x, iResolution.y), 0.0 );
    float secondy = getFirstThresholdPixel( vec2(fragCoord.x, firsty - 1.0), amount);

    //Only work on the pixels that are between the two threshold pixels
    if( fragCoord.y < firsty && fragCoord.y > secondy )
    {
		float size = firsty - secondy;

		vec4 colorarray[10];
		putItIn( vec2(fragCoord.x, secondy), size, colorarray );
		sortArray( colorarray );
	
		float sectionSize = size / 9.0;
		float location = floor( (fragCoord.y - secondy) / sectionSize );
		float bottom = secondy + (sectionSize * location);
		float locationBetween = (fragCoord.y - bottom) / sectionSize;

        //A simple method for "fading" between the colors of our ten sampled pixels
		vec4 topColor = colorarray[int(location) + 1] * locationBetween;
		vec4 bottomColor = colorarray[int(location)] * (1.0 - locationBetween);
		
		fragColor = topColor + bottomColor;
    }
    else
    {
		fragColor = texture( iChannel0, (fragCoord.xy / iResolution.xy) );
    }
}