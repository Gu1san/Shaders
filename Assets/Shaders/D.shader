Shader "Custom/D"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _StripeWidth("Largura das listras", Range(0.01, 0.3)) = 0.2
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        sampler2D _MainTex;
        float _StripeWidth;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            float x = IN.uv_MainTex.x;
            float y = IN.uv_MainTex.y;

            float diagonal = frac((x - y) / _StripeWidth);

            // Cria as listras diagonais
            float stripes = diagonal > 0.5 ? 1.0 : 0.0;

            o.Albedo = stripes;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

