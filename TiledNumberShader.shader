Shader "TiledNumberShader"
{
    Properties
    {
        [NoScaleOffset] _MainTex ("Texture", 2D) = "black" {}
        _TexSizeX("Tex Size X", int) = 32
        _TexSizeY("Tex Size Y", int) = 16
        _UseSizeX("Use Region X", int) = 30
        _UseSizeY("Use Region Y", int) = 14
        _Col("Column Count", int) = 6
        _Row("Row Count", int) = 2
        _Number("Number", int) = 0
        _DigitCount("Digit Count", int) = 4
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _TexSizeX;
            float _TexSizeY;
            float _UseSizeX;
            float _UseSizeY;
            float _Col;
            float _Row;
            float _Number;
            float _DigitCount;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            #include "TiledNumber.cginc"
            
            fixed4 frag(v2f i) : SV_Target
            {
                uint col = (uint)_Col;
                uint row = (uint)_Row;
                uint number = (uint)_Number;
                uint digitCountInt = (uint)_DigitCount;
                uint digit = (int)(i.uv.x * _DigitCount);
				uint n = number / ((uint)round(pow(10, _DigitCount - digit - 1))) % 10;
				float2 uv = TiledNumber_placeTileUV(
                    i.uv,
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
            ENDCG
        }
    }
}
