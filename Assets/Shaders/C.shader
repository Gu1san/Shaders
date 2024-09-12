Shader "Custom/C"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Color1("Color 1", Color) = (1, 0, 0, 1)
        _Color2("Color 2", Color) = (0, 0, 1, 1)
    }
        SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        fixed4 _Color1;
        fixed4 _Color2;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float x = IN.uv_MainTex.x;
            float y = IN.uv_MainTex.y;

            //Diagonal descendo
            float a = saturate(1 - (x + y));

            //Diagonal subindo
            float b = saturate((y - x));

            //Multiplicando as cores
            float3 c = a * _Color1;
            float3 d = b * _Color2;

            //Somando as duas diagonais e trocando o preto por branco
            o.Albedo = (c + d) + (1 - (a + b));
        }
        ENDCG
    }
        FallBack "Diffuse"
}

