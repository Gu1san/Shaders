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

            //gerando uma diagonal com os valores absolutos de X e Y
            float a = abs(y / x);
            float b = abs(x - y);

            o.Albedo = a + b;
            //o.Albedo = lerp(_Color1.rgb, _Color2.rgb, a);
        }
        ENDCG
    }
        FallBack "Diffuse"
}

