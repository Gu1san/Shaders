Shader "Custom/L"
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
        float _Radius;
        float _StripeWidth;
        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Calcula o centro da textura
            float2 centeredUV = IN.uv_MainTex - 0.5;

            // Calcula a distância do centro
            float distance = length(centeredUV);

            // Cria listras baseadas na distância do centro
            float stripes = frac(distance / _StripeWidth) > 0.3 ? 1.0 : 0.0;

            //Invertendo as cores
            float s = 1 - stripes;

            // Aplica o azul no círculo
            o.Albedo = s;
        }
        ENDCG
    }
        FallBack "Diffuse"
}

