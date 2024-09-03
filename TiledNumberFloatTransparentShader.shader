Shader "TiledNumber/TiledNumberFloatTransparentShader"
{
    Properties
    {
        _MinNumber("Min Number", int) = 0
        _MaxNumber("Max Number", int) = 0
        _NumberRate("Number Rate", float) = 0
        _DigitCount("Digit Count", int) = 4
        [MaterialToggle] _ZeroFill("Zero Fill", float) = 1
        _Color("Color", Color) = (1, 1, 1, 1)
        _BackgroundColor("Background Color", Color) = (0, 0, 0, 0)
        [Space]
        [NoScaleOffset] _MainTex ("Texture", 2D) = "black" {}
        _TexSizeX("Tex Size X", int) = 32
        _TexSizeY("Tex Size Y", int) = 16
        _UseSizeX("Use Region X", int) = 30
        _UseSizeY("Use Region Y", int) = 14
        _Col("Column Count", int) = 6
        _Row("Row Count", int) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        Blend SrcAlpha OneMinusSrcAlpha
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

            #include "TiledNumberShader.cginc"

            float _MinNumber;
            float _MaxNumber;
            float _NumberRate;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                return coloredNumberTex(i.uv, (uint)lerp(_MinNumber, _MaxNumber, _NumberRate));
            }
            ENDCG
        }
    }
}
