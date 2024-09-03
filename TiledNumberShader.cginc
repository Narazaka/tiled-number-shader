// Do not include this file. This is not public API. It is subject to change without notice.

sampler2D _MainTex;
float4 _MainTex_ST;
float _TexSizeX;
float _TexSizeY;
float _UseSizeX;
float _UseSizeY;
float _Col;
float _Row;
float _DigitCount;
float _ZeroFill;

#include "TiledNumber.cginc"
            
fixed4 numberTex(float2 uv, uint number)
{
    uint col = (uint)_Col;
    uint row = (uint)_Row;
    uint digitCountInt = (uint)_DigitCount;
    uint digit = (int)(uv.x * _DigitCount);
    uint unit = (uint)round(pow(10, _DigitCount - digit - 1));
	uint n = lerp(number / unit % 10, col * row - 1, _ZeroFill < 0.5 && number < unit);
	uv = TiledNumber_placeTileUV(
        uv,
        float2(1 / _DigitCount, 1),
        float2(digit / _DigitCount, 0),
        float2(_UseSizeX / _TexSizeX, _UseSizeY / _TexSizeY),
        float2(0, 1 - _UseSizeY / _TexSizeY),
        n,
        col,
        row,
        false
    );
    return tex2D(_MainTex, uv);
}

float4 _Color;
float4 _BackgroundColor;

fixed4 coloredNumberTex(float2 uv, uint number)
{
    fixed4 c = numberTex(uv, number);
    return lerp(_BackgroundColor, _Color, c.r);
}
