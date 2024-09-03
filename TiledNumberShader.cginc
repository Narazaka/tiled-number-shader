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
    uv = TiledNumber_placeTileUV(
        uv,
        float2(1, 1),
        float2(0, 0),
        float2(_UseSizeX / _TexSizeX, _UseSizeY / _TexSizeY),
        float2(0, 1 - _UseSizeY / _TexSizeY),
        number,
        (uint)_Col,
        (uint)_Row,
        false,
        (uint)_DigitCount,
        _ZeroFill > 0.5
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
